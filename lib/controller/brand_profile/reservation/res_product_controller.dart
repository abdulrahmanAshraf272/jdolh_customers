import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_parent_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'dart:async';
import 'package:jdolh_customers/core/functions/calc_invitors_bills.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/groups.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/group.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ResProductController extends ResParentController {
  List<Resinvitors> resInvitors = [];
  bool withInvitation = false;
  GroupsData groupsData = GroupsData(Get.find());
  double creatorCost = 0;

  List<Friend> members = [];
  TextEditingController extraSeats = TextEditingController();

  onTapAddMembers() async {
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members, "withGroups": true});
    if (result is Friend) {
      members.add(result);
      Resinvitors invitor = Resinvitors(
          userid: result.userId,
          userName: result.userName,
          userImage: result.userImage,
          type: 1,
          cost: 0);
      resInvitors.add(invitor);
      update();
    } else if (result is Group) {
      addGroupToReservation(result);
    }
  }

  addGroupToReservation(Group group) async {
    CustomDialogs.loading();
    var response = await groupsData.groupMembers(group.groupId.toString());
    CustomDialogs.dissmissLoading();
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List groupMembersJson = response['data'];
        List<Friend> groupMembers =
            groupMembersJson.map((friend) => Friend.fromJson(friend)).toList();
        int myId = int.parse(myServices.getUserid());

        //Remove myself if i am exist in the group
        groupMembers.removeWhere((friend) => friend.userId == myId);

        //Remove any user that already exist in members
        groupMembers.removeWhere((groupUser) =>
            members.any((member) => member.userId == groupUser.userId));
        members.addAll(groupMembers);
        for (int i = 0; i < groupMembers.length; i++) {
          Resinvitors invitor = Resinvitors(
              userid: groupMembers[i].userId,
              userName: groupMembers[i].userName,
              userImage: groupMembers[i].userImage,
              type: 1,
              cost: 0);
          resInvitors.add(invitor);
        }
        CustomDialogs.success('تم اضافة اعضاء المجموعة');
        update();
      } else {
        CustomDialogs.failure();
        print('adding memeber failed');
      }
    } else {
      print('statusReques: $statusRequest');
      update();
    }
  }

  // onTapPayForHimself(int index) {
  //   resInvitors[index].type = 0;
  //   update();
  // }

  onTapDivideBill(int index) {
    resInvitors[index].type = 1;
    update();
  }

  onTapWithoutPayBill(int index) {
    resInvitors[index].type = 2;
    update();
  }

  // === Add Invitors===//
  switchWithInvitors(bool value) {
    withInvitation = value;
    update();
  }

  removeMember(index) {
    resInvitors.removeAt(index);
    members.removeAt(index);
    update();
  }

  bool checkInvitorsWithinLimitation() {
    //Make sure the min and max invitor
    if (resDetails.invitorMin != 0 && resDetails.invitorMin != null) {
      if (resInvitors.length < resDetails.invitorMin!) {
        Get.rawSnackbar(
            message:
                'العدد الادنى للأشخاص للحجز في هذا المكان هو ${resDetails.invitorMin}');
        return false;
      }
    } else if (resDetails.invitorMax != 0 && resDetails.invitorMax != null) {
      if (resInvitors.length > resDetails.invitorMax!) {
        Get.rawSnackbar(
            message:
                'العدد الاقصى للأشخاص للحجز في هذا المكان هو ${resDetails.invitorMax}');
        return false;
      }
    }
    return true;
  }

  onTapCreateReservationWithInvitors() async {
    if (checkAllFeilds()) {
      // 1- Calculate each invitor bill
      calculateInvitorsShare();

      // 2- create hold reservation
      CustomDialogs.loading();
      final reservation = await createHoldRes();
      if (reservation is Reservation) {
        // 3- Send Invitations
        int resid = reservation.resId!;
        bool result = await sendInvitations(resid);
        if (result) {
          CustomDialogs.dissmissLoading();
          CustomDialogs.success('تم ارسال الدعوات');

          // 4- Send Notifications to the invitors
          reservationNotification.sendInvitations(resInvitors, reservation);

          // 5- Go to ReservationConfirmWait screen
          gotoReservationConfirmWait();
        } else {
          CustomDialogs.dissmissLoading();
          CustomDialogs.failure();
        }
      } else {
        CustomDialogs.dissmissLoading();
        CustomDialogs.failure();
      }
    }
  }

  calculateInvitorsShare() {
    double totalPrice;
    if (brandProfileController.paymentType == 'RB') {
      totalPrice =
          cartController.totalPrice + cartController.billTax + resCost + resTax;
    } else {
      totalPrice = resCost + resTax;
    }

    print('amount: ${totalPrice}');

    resInvitors = List.of(calInvitorsBills(totalPrice, resInvitors));

    for (int i = 0; i < resInvitors.length; i++) {
      print('${resInvitors[i].userName}: ${resInvitors[i].cost}');
    }
  }

  createHoldRes() async {
    double totalPriceWithTax =
        cartController.totalPrice + cartController.billTax + resCost + resTax;
    //
    int duration = 0;
    if (brandProfileController.brand.brandIsService == 0) {
      //if product => duration is saved in resOption
      duration = brandProfileController.selectedResOption.resoptionsDuration!;
    } else {
      //if service => get the total duration from all items in cart
      duration = cartController.totalServiceDuration;
    }

    //To Calculate creator price
    double totalPrice;
    if (brandProfileController.paymentType == 'RB') {
      totalPrice = totalPriceWithTax;
    } else {
      totalPrice = resCost + resTax;
    }
    creatorCost = calcCreatorCost(totalPrice, resInvitors);

    print('creator cost = ${creatorCost}');
    print('extra seats: ${extraSeats.text}');
    var response = await resData.createRes(
        paymentType: brandProfileController.paymentType,
        userid: myServices.getUserid(),
        bchid: bchid.toString(),
        brandid: brandid.toString(),
        date: selectedDate,
        time: selectedTime,
        duration: duration.toString(),
        billCost: cartController.totalPrice.toStringAsFixed(2),
        billTax: cartController.billTax.toStringAsFixed(2),
        resCost: resCost.toStringAsFixed(2),
        resTax: resTax.toStringAsFixed(2),
        totalPrice: totalPriceWithTax.toStringAsFixed(2),
        billPolicy: billPolicy.toString(),
        resPolicy: resPolicy.toString(),
        isHomeService: brandProfileController.isHomeServices ? '1' : '0',
        withInvitores: '1',
        resOption: selectedResOption.resoptionsTitle!,
        status: '-1',
        extraSeats: extraSeats.text.toString(),
        creatorCost: creatorCost.toString()); //-1 refer to holding status.
    statusRequest = handlingData(response);
    print('create reservation $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('create reservation succeed');
        reservation = Reservation.fromJson(response['data']);
        reservation.brandLogo = brandProfileController.brand.brandLogo;
        reservation.bchContactNumber =
            brandProfileController.bch.bchContactNumber;
        reservation.brandName = brandProfileController.brand.brandStoreName;
        reservation.bchLocation = brandProfileController.bch.bchLocation;
        reservation.bchLat = brandProfileController.bch.bchLat;
        reservation.bchLng = brandProfileController.bch.bchLng;
        return reservation;
      }
    }
  }

  Future<bool> sendInvitations(int resid) async {
    bool isSendingDone = false;

    // Send the first invitation and wait for its response
    var firstResponse = await resData.sendInvitation(
      resid: resid.toString(),
      userid: resInvitors[0].userid.toString(),
      creatorid: myServices.getUserid(),
      type: resInvitors[0].type.toString(),
      cost: resInvitors[0].cost.toString(),
    );

    StatusRequest statusRequest = handlingData(firstResponse);
    if (statusRequest == StatusRequest.success &&
        firstResponse['status'] == 'success') {
      isSendingDone = true;

      // Collect futures for the remaining invitations
      List<Future> invitationFutures = [];
      for (int i = 1; i < resInvitors.length; i++) {
        invitationFutures.add(resData.sendInvitation(
          resid: resid.toString(),
          userid: resInvitors[i].userid.toString(),
          creatorid: myServices.getUserid(),
          type: resInvitors[i].type.toString(),
          cost: resInvitors[i].cost.toString(),
        ));
      }

      // Send all remaining invitations concurrently
      await Future.wait(invitationFutures);
    }

    return isSendingDone;
  }

  gotoReservationConfirmWait() {
    cartController.clearCart();
    for (Resinvitors invitror in resInvitors) {
      invitror.status = 0;
    }

    //Add Myself
    int myId = int.parse(myServices.getUserid());
    resInvitors.add(Resinvitors(
        userid: myId,
        creatorid: myId,
        userName: myServices.getName(),
        userImage: myServices.getImage(),
        cost: creatorCost));

    Get.toNamed(AppRouteName.reservationConfirmWait, arguments: {
      'res': reservation,
      'resInvitors': resInvitors,
      "holdTime": resDetails.suspensionTimeLimit,
      "reviewRes": reviewRes,
      "resPolicy": brandProfileController.resPolicy,
      "billPolicy": brandProfileController.billPolicy,
      "brand": brandProfileController.brand
    });
  }

  bool checkAllFeilds() {
    if (cartController.carts.isEmpty) {
      Get.rawSnackbar(message: 'السلة فارغة!'.tr);
      return false;
    }
    if (selectedDate == '') {
      Get.rawSnackbar(message: 'من فضلك اختر وقت الحجز'.tr);
      return false;
    }
    if (resInvitors.isEmpty) {
      Get.rawSnackbar(message: 'من فضلك قم باختيار المدعوين'.tr);
      return false;
    }
    return true;
  }
}
