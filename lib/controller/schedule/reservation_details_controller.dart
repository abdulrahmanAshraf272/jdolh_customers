import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/core/functions/sweet_bottom_sheet.dart';
import 'package:jdolh_customers/core/notification/notification_sender/reservation_notification.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:sweetsheet/sweetsheet.dart';

class ReservationDetailsController extends GetxController {
  StatusRequest statusGetInvitors = StatusRequest.none;
  List<Resinvitors> resInvitors = [];
  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());
  MyServices myServices = Get.find();
  bool isService = false;
  late Reservation reservation;
  String resTime = '';
  List<Cart> carts = [];
  String customerName = '';
  String customerEmail = '';
  String customerPhone = '';

  bool phoneNumberValid = false;

  onTapCancelReservation(BuildContext context) {
    sweetBottomSheet(
        context: context,
        title: "الغاء الحجز",
        desc: 'رسوم الحجز غير مستردة عند الغاء الحجز',
        confirmButtonText: 'تأكيد',
        onTapConfirm: () {
          Get.back();
          cancelReservation();
          ReservationNotification reservationNotification =
              ReservationNotification();
          reservationNotification.cancelReservation(
              reservation.bchid!, reservation.resDate!);
        },
        color: SweetSheetColor.DANGER,
        icon: Icons.cancel);
  }

  cancelReservation() async {
    changeResStatus('4');
    Get.back(result: reservation);
  }

  String displayResTime(String timeString) {
    timeString = timeString.trim();
    DateTime time = DateFormat.Hm().parse(timeString);
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  changeResStatus(String status) async {
    CustomDialogs.loading();
    var response = await resData.changeResStatus(
        resid: reservation.resId.toString(),
        status: status,
        rejectionReason: '');
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success();
      } else {
        print('failure');
      }
    }
    update();
  }

  getResCart() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await resData.getResCart(resid: reservation.resId.toString());
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('getResCart success');

        parseValues(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  parseValues(response) {
    List data = response['data'];
    carts = data.map((e) => Cart.fromJson(e)).toList();
    print(carts.length);
    print(carts[0].cartId);
  }

  onTapDisplayLocation() {
    String location = reservation.bchLocation ?? '';
    String locationLink = reservation.bchLocationLink ?? '';

    if (locationLink == '') {
      goToDisplayLocation();
      return;
    }

    if (location != '' && locationLink != '') {
      Get.bottomSheet(Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: AppColors.gray,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اختر طريقة عرض الموقع',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 20),
            GoHomeButton(
                onTap: () {
                  openUrlLink(locationLink);
                },
                text: 'تطبيق Googel Maps',
                width: Get.width - 40,
                height: 38.h),
            const SizedBox(height: 10),
            GoHomeButton(
                onTap: () {
                  goToDisplayLocation();
                },
                text: 'روية الموقع هنا',
                width: Get.width - 40,
                height: 38.h),
          ],
        ),
      ));
    }
  }

  callBch() {
    String contactNumber = reservation.bchContactNumber ?? '';
    if (contactNumber == '') {
      Get.rawSnackbar(message: 'الرقم غير صالح');
      return;
    }
    openContactApp(contactNumber);
  }

  goToDisplayLocation() {
    double lat = double.parse(reservation.bchLat!);
    double lng = double.parse(reservation.bchLng!);
    Get.toNamed(AppRouteName.diplayLocation, arguments: LatLng(lat, lng));
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

  @override
  void onInit() {
    if (Get.arguments != null) {
      reservation = Get.arguments['res'];

      if (reservation.resWithInvitors == 1) {
        getInvitors();
      }

      resTime = displayResTime(reservation.resTime!);
    }
    print(reservation.bchLocation);
    getResCart();
    super.onInit();
  }
}
