import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_parent_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'dart:async';
import 'package:jdolh_customers/core/functions/calc_invitors_bills.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ResProductController extends ResParentController {
  List<Resinvitors> resInvitors = [];
  bool withInvitation = false;

  List<Friend> members = [];
  TextEditingController extraSeats = TextEditingController();

  onTapAddMembers() async {
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members});
    if (result is Friend) {
      members.add(result);
      Resinvitors invitor = Resinvitors(
          userid: result.userId,
          userName: result.userName,
          userImage: result.userImage,
          type: 0,
          cost: 0);
      resInvitors.add(invitor);
      update();
    }
  }

  onTapPayForHimself(int index) {
    resInvitors[index].type = 0;
    update();
  }

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
    update();
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
    double totalCost =
        cartController.totalPrice + resCost + cartController.taxCost;
    resInvitors = List.of(calInvitorsBills(totalCost, resInvitors, extraSeats));
  }

  createHoldRes() async {
    double totalPrice = cartController.totalPrice;
    double taxCost = cartController.taxCost;
    double totalPriceWithTax = totalPrice + taxCost + resCost;
    //
    int duration = 0;
    if (brandProfileController.brand.brandIsService == 0) {
      //if product => duration is saved in resOption
      duration = brandProfileController.selectedResOption.resoptionsDuration!;
    } else {
      //if service => get the total duration from all items in cart
      duration = cartController.totalServiceDuration;
    }
    var response = await resData.createRes(
        userid: myServices.getUserid(),
        bchid: bchid.toString(),
        brandid: brandid.toString(),
        date: selectedDate,
        time: selectedTime,
        duration: duration.toString(),
        price: totalPrice.toString(),
        resCost: resCost.toString(),
        taxCost: taxCost.toString(),
        totalPrice: totalPriceWithTax.toString(),
        billPolicy: billPolicy.toString(),
        resPolicy: resPolicy.toString(),
        isHomeService: brandProfileController.isHomeServices ? '1' : '0',
        withInvitores: '1',
        resOption: selectedResOption.resoptionsTitle!,
        status: '-1'); //-1 refer to holding status.
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
    Get.toNamed(AppRouteName.reservationConfirmWait, arguments: {
      'reservation': reservation,
      'resInvitors': resInvitors,
      "holdTime": resDetails.suspensionTimeLimit
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
