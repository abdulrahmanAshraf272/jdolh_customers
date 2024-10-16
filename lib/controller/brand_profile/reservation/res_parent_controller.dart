import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/cart_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/reservation_notification.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/cart.dart';
import 'package:jdolh_customers/data/data_source/remote/home_services.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/data_source/remote/resDetails.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/home_services.dart';
import 'package:jdolh_customers/data/models/resOption.dart';
import 'package:jdolh_customers/data/models/res_details.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ResParentController extends GetxController {
  ReservationNotification reservationNotification = ReservationNotification();
  Reservation reservation = Reservation();
  ResData resData = ResData(Get.find());
  bool viewRefresh = false;
  StatusRequest statusRequest = StatusRequest.none;
  HomeServicesData homeServicesData = HomeServicesData(Get.find());
  ResDetailsData resDetailsData = ResDetailsData(Get.find());
  CartData cartData = CartData(Get.find());
  MyServices myServices = Get.find();
  BrandProfileController brandProfileController = Get.find();
  String selectedResDateTime = '';
  String selectedDate = '';
  String selectedTime = '';

  late int bchid;
  late int brandid;
  HomeServices homeServices = HomeServices();
  ResDetails resDetails = ResDetails();
  CartController cartController = Get.find();

  String reservationCondition = '';

  int reviewRes = 0;

  List<ResOption> resOptions = [];
  List<String> resOptionsTitles = [];
  late ResOption selectedResOption;
  selectResOption(String resOptionTitle) {
    selectedResOption = resOptions
        .firstWhere((element) => element.resoptionsTitle == resOptionTitle);
  }

  double resCost = 0;
  double resTax = 0;

  late int resPolicy;
  late int billPolicy;

  //================================

  getResCost() {
    if (brandProfileController.isHomeServices) {
      resCost = homeServices.cost!;
    } else {
      resCost = resDetails.cost!;
    }
    resTax = resCost * brandProfileController.resTaxPercent;
  }

  void gotoSetResTime() async {
    print('shit');
    // if (cartController.carts.isEmpty) {
    //   String message = brandProfileController.brand.brandIsService == 1
    //       ? 'من فضلك قم بإضافة الخدمات ثم قم بتحديد وقت الحجز'.tr
    //       : 'من فضلك قم بإضافة المنتجات ثم قم بتحديد وقت الحجز'.tr;
    //   Get.rawSnackbar(message: message);
    //   return;
    // }
    int timeout = 0;
    if (brandProfileController.isHomeServices == true) {
      timeout = homeServices.timeout ?? 0;
    } else {
      timeout = resDetails.timeout ?? 0;
    }

    print('timeout=========$timeout');
    print('bchid: $bchid');
    final result = await Get.toNamed(AppRouteName.setResTime, arguments: {
      "bchid": bchid,
      "resOption": selectedResOption,
      "timeout": timeout
    });
    if (result != null) {
      selectedDate = result['date'];
      selectedTime = result['time'];
      selectedResDateTime = '$selectedDate $selectedTime';
      print('date: $selectedDate ======== time: $selectedTime');
      update();
    }
  }

  createRes() async {
    if (checkConditions()) {
      double totalPriceWithTax =
          cartController.totalPrice + cartController.billTax + resCost + resTax;

      int totalDuration = getTotalDuration();
      //in case it is service(duration calculate by the services times) and the cart is empty
      if (totalDuration == 0) {
        totalDuration = 30;
      }

      var response = await resData.createRes(
          paymentType: brandProfileController.paymentType,
          userid: myServices.getUserid(),
          bchid: bchid.toString(),
          brandid: brandid.toString(),
          date: selectedDate,
          time: selectedTime,
          duration: totalDuration.toString(),
          billCost: cartController.totalPrice.toString(),
          billTax: cartController.billTax.toString(),
          resCost: resCost.toString(),
          resTax: resTax.toString(),
          totalPrice: totalPriceWithTax.toString(),
          billPolicy: billPolicy.toString(),
          resPolicy: resPolicy.toString(),
          isHomeService: brandProfileController.isHomeServices ? '1' : '0',
          withInvitores: '0',
          resOption: selectedResOption.resoptionsTitle!,
          status: reviewRes == 0 ? '1' : '0');
      statusRequest = handlingData(response);
      print('create reservation $statusRequest');
      print('response: $response');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          print('create reservation succeed');
          reservation = Reservation.fromJson(response['data']);

          reservation = injectBrandAndBchDataInReservationsObject(reservation);

          //send Notification
          if (reviewRes == 0) {
            reservationNotification.sendReserveNotification(
                bchid, selectedDate, reservation.resId!);
          } else {
            reservationNotification.sendReserveRequistNotification(
                bchid, selectedDate, reservation.resId!);
          }

          return reservation;
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    }
  }

  onTapConfirmRes() async {
    CustomDialogs.loading();
    var reservation = await createRes();
    CustomDialogs.dissmissLoading();
    if (reservation != null) {
      navigateToPaymentOrWaitForApprove();
    }
  }

  navigateToPaymentOrWaitForApprove() {
    cartController.clearCart();

    if (checkIfNoCostToPay() == true) {
      return;
    }

    if (reviewRes == 0) {
      Get.offNamed(AppRouteName.payment, arguments: {
        "res": reservation,
        "resPolicy": brandProfileController.resPolicy,
        "billPolicy": brandProfileController.billPolicy,
      });
    } else {
      Get.offNamed(AppRouteName.waitForApprove, arguments: {
        "res": reservation,
        "resPolicy": brandProfileController.resPolicy,
        "billPolicy": brandProfileController.billPolicy,
      });
    }
  }

  bool checkIfNoCostToPay() {
    if (reviewRes == 0) {
      if ((brandProfileController.paymentType == 'R' && resCost == 0) ||
          (brandProfileController.paymentType == 'RB' &&
              resCost == 0 &&
              cartController.totalPrice == 0)) {
        Get.offNamed(AppRouteName.paymentResult,
            arguments: {"res": reservation, "paymentMethod": 'wallet'});
        return true;
      }
    }
    return false;
  }

  bool checkConditions() {
    // if (cartController.carts.isEmpty) {
    //   Get.rawSnackbar(message: 'السلة فارغة!'.tr);
    //   return false;
    // }
    if (selectedDate == '') {
      Get.rawSnackbar(message: 'من فضلك اختر وقت الحجز'.tr);
      return false;
    }
    if (checkAllItemsAvailableWithinResOptionSelected() == false) {
      return false;
    }

    return true;
  }

  bool checkAllItemsAvailableWithinResOptionSelected() {
    List<dynamic> resItemsId = selectedResOption.itemsRelated!;
    List<Cart> carts = cartController.carts;
    for (int i = 0; i < carts.length; i++) {
      if (!resItemsId.contains(carts[i].itemsId)) {
        String warningMessage =
            '${carts[i].itemsTitle} ${'غير متوفر ضمن تفضيل'.tr} ${selectedResOption.resoptionsTitle}\n ${'قم بإزالة'.tr} ${carts[i].itemsTitle} ${'او قم بتغيير التفضيل'.tr}';
        Get.rawSnackbar(
            message: warningMessage, duration: const Duration(seconds: 4));
        return false;
      }
    }
    return true;
  }

  Reservation injectBrandAndBchDataInReservationsObject(
      Reservation reservation) {
    reservation.brandLogo = brandProfileController.brand.brandLogo;
    reservation.bchContactNumber = brandProfileController.bch.bchContactNumber;
    reservation.brandName = brandProfileController.brand.brandStoreName;
    reservation.bchLocation = brandProfileController.bch.bchLocation;
    reservation.bchLat = brandProfileController.bch.bchLat;
    reservation.bchLng = brandProfileController.bch.bchLng;
    return reservation;
  }

  int getTotalDuration() {
    int duration = 0;
    if (brandProfileController.brand.brandIsService == 0) {
      //if product => duration is saved in resOption
      duration = brandProfileController.selectedResOption.resoptionsDuration!;
    } else {
      //if service => get the total duration from all items in cart
      duration = cartController.totalServiceDuration;
    }
    return duration;
  }

  // onTapConfirmReservation() {
  //   if (brandProfileController.carts.isEmpty) {
  //     Get.rawSnackbar(message: 'السلة فارغة!');
  //     return;
  //   }
  //   if (selectedDate == '') {
  //     Get.rawSnackbar(message: 'من فضلك اختر وقت الحجز');
  //     return;
  //   }
  //   createRes();
  // }

  getHomeServices() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await homeServicesData.getHomeServices(bchid: bchid.toString());
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        homeServices = HomeServices.fromJson(response['data']);
        reviewRes = homeServices.reviewRes!;
        print(homeServices.maxDistance);
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  getResDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resDetailsData.getResDetails(bchid: bchid.toString());
    statusRequest = handlingData(response);
    print('hello people');
    print('statusRequest =====$statusRequest');

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        resDetails = ResDetails.fromJson(response['data']);
        reviewRes = resDetails.reviewRes!;

        reservationCondition = resDetails.additionalInfo ?? '';
        print('resDetails timeout : ${resDetails.timeout}');
        print('success');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getData() async {
    if (brandProfileController.isHomeServices == true) {
      await getHomeServices();
    } else {
      await getResDetails();
    }
    getResCost();
    print('resCost: $resCost');
  }

  @override
  void onInit() async {
    //Get ResOption
    resOptions = List.from(brandProfileController.resOptions);
    resOptionsTitles = List.from(brandProfileController.resOptionsTitles);
    selectedResOption = brandProfileController.selectedResOption;
    bchid = brandProfileController.bch.bchId!;
    brandid = brandProfileController.brand.brandId!;
    resPolicy = brandProfileController.bch.bchResPolicyid ?? 0;
    billPolicy = brandProfileController.bch.bchBillPolicyid ?? 0;
    getData();

    super.onInit();
  }
}
