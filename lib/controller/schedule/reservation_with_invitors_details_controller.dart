import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/core/functions/sweet_bottom_sheet.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
import 'package:sweetsheet/sweetsheet.dart';

class ReservationWithInvitorsDetailsController extends GetxController {
  late Reservation reservation;
  StatusRequest statusResCart = StatusRequest.none;
  StatusRequest statusGetInvitors = StatusRequest.none;
  List<Resinvitors> resInvitors = [];
  List<Cart> carts = [];
  String resTime = '';
  bool displayResInvitorsPart = true;
  ResData resData = ResData(Get.find());
  MyServices myServices = Get.find();

  changeSubscreen(bool displayResInvitor) {
    displayResInvitorsPart = displayResInvitor;
    update();
    if (!displayResInvitor && carts.isEmpty) {
      getResCart();
    }
  }

  onTapLeaveReservation(BuildContext context) {
    sweetBottomSheet(
        context: context,
        title: "مغادرة الحجز".tr,
        desc: 'اذا قمت بدفع رسوم,لا يوجد استرداد للرسوم في حالة المغادرة'.tr,
        onTapConfirm: () {
          Get.back();
          rejectInvitation();
        },
        confirmButtonText: 'تأكيد'.tr,
        color: SweetSheetColor.DANGER,
        icon: Icons.cancel);
  }

  onTapCancelReservation(BuildContext context) {
    sweetBottomSheet(
        context: context,
        title: "الغاء الحجز".tr,
        desc: 'رسوم الحجز غير مستردة عند الغاء الحجز'.tr,
        confirmButtonText: 'تأكيد'.tr,
        onTapConfirm: () {
          Get.back();
          cancelReservation();
        },
        color: SweetSheetColor.DANGER,
        icon: Icons.cancel);
  }

  onTapAccept(BuildContext context) {
    if (reservation.invitorAmount == 0) {
      acceptInvitation();
    } else {
      sweetBottomSheet(
          context: context,
          title: '${'الرسوم'.tr}: ${reservation.invitorAmount} ${'ريال'.tr}',
          desc:
              'عند الضغط على قبول سيتم تحويل الرسوم من محفظتك وتحويلها لمحفظة صديقك الذي ارسل الدعوة ليقوم بتأكيد الحجز'
                  .tr,
          confirmButtonText: 'قبول'.tr,
          onTapConfirm: () {
            Get.back();
            acceptInvitation();
          },
          color: SweetSheetColor.SUCCESS,
          icon: Icons.done);
    }
  }

  onTapReject(BuildContext context) {
    sweetBottomSheet(
        context: context,
        title: 'رفض'.tr,
        desc: '${'هل تريد رفض دعوة'.tr} ${reservation.username} ?',
        confirmButtonText: 'تأكيد'.tr,
        onTapConfirm: () {
          Get.back();
          rejectInvitation();
        },
        color: SweetSheetColor.DANGER,
        icon: Icons.cancel);
  }

  acceptInvitation() async {
    CustomDialogs.loading();
    var response = await resData.acceptInvitation(
        resid: reservation.resId.toString(),
        userid: myServices.getUserid(),
        creatorId: reservation.resUserid.toString());
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        double price = reservation.invitorAmount ?? 0;
        String ss =
            price != 0 ? 'وقام بتحويل رسومه الى محفظتك لتقوم بتأكيد الحجز' : '';
        NotificationSender.sendToCustomer(
            userid: reservation.resUserid!,
            title: 'تأكيد حضور',
            body: 'قام ${myServices.getUsername()} بقبول دعوة الحجز $ss',
            routeName: AppRouteName.reservationConfirmWait);

        CustomDialogs.success();
        Get.back(result: true);
      } else if (response['message'] == 'not enough money') {
        CustomDialogs.failure('لا يوجد لديك رصيد كاف'.tr);
      } else {
        CustomDialogs.failure();
      }
    }
  }

  rejectInvitation() async {
    CustomDialogs.loading();
    var response = await resData.rejectInvitation(
        resid: reservation.resId.toString(), userid: myServices.getUserid());
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        NotificationSender.sendToCustomer(
            userid: reservation.resUserid!,
            title: 'اعتذار عن الحضور',
            body: 'قام ${myServices.getUsername()} برفض دعوة الحجز',
            routeName: AppRouteName.reservationConfirmWait);

        CustomDialogs.success();
        Get.back(result: true);
      } else {
        CustomDialogs.failure();
      }
    }
  }

  cancelReservation() async {
    CustomDialogs.loading();
    var response = await resData.changeResStatus(
        resid: reservation.resId.toString(), status: '4', rejectionReason: '');
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success();
        Get.back(result: true);
      } else {
        CustomDialogs.failure();
      }
    }
  }

  getResCart() async {
    statusResCart = StatusRequest.loading;
    update();
    var response =
        await resData.getResCart(resid: reservation.resId.toString());
    statusResCart = handlingData(response);
    print('statusRequest ==== $statusResCart');
    if (statusResCart == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        carts = data.map((e) => Cart.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
  }

  getInvitors() async {
    statusGetInvitors = StatusRequest.loading;
    update();
    var response =
        await resData.getInvitors(resid: reservation.resId.toString());
    statusGetInvitors = handlingData(response);
    print('statusGetInvitors: ${statusGetInvitors}');
    if (statusGetInvitors == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseGetInvitors(response);
      } else {
        statusGetInvitors = StatusRequest.failure;
      }
    }
    update();
  }

  parseGetInvitors(response) {
    print('success get invitors');
    List data = response['data'];
    resInvitors.clear();
    resInvitors = data.map((e) => Resinvitors.fromJson(e)).toList();
  }

  onTapDisplayLocation() {
    double lat = double.parse(reservation.bchLat!);
    double lng = double.parse(reservation.bchLng!);
    Get.toNamed(AppRouteName.diplayLocation, arguments: LatLng(lat, lng));
  }

  String displayResTime(String timeString) {
    timeString = timeString.trim();
    DateTime time = DateFormat.Hm().parse(timeString);
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  callBch() {
    String contactNumber = reservation.bchContactNumber ?? '';
    if (contactNumber == '') {
      Get.rawSnackbar(message: 'الرقم غير صالح'.tr);
      return;
    }
    openContactApp(contactNumber);
  }

  //TODO to get reservation in case onTap notification
  getReservation() {}

  receiveArgument() async {
    if (Get.arguments['res'] is Reservation) {
      reservation = Get.arguments['res'];
    } else {
      reservation = await getReservation();
    }
  }

  @override
  void onInit() async {
    await receiveArgument();
    getInvitors();
    resTime = displayResTime(reservation.resTime!);
    print('reservation resStatus: ${reservation.invitorStatus}');
    super.onInit();
  }
}
