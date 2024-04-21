import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/cart.dart';
import 'package:jdolh_customers/data/data_source/remote/home_services.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/data_source/remote/resDetails.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/home_services.dart';
import 'package:jdolh_customers/data/models/resOption.dart';
import 'package:jdolh_customers/data/models/res_details.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ResParentController extends GetxController {
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
  bool withInvitation = false;
  late int bchid;
  late int brandid;
  HomeServices homeServices = HomeServices();
  ResDetails resDetails = ResDetails();

  int reviewRes = 0;

  List<ResOption> resOptions = [];
  List<String> resOptionsTitles = [];
  late ResOption selectedResOption;
  selectResOption(String resOptionTitle) {
    selectedResOption = resOptions
        .firstWhere((element) => element.resoptionsTitle == resOptionTitle);
  }

  num resCost = 0;

  late int resPolicy;
  late int billPolicy;

  //================================

  getResCost() {
    if (brandProfileController.isHomeServices) {
      resCost = homeServices.cost!;
    } else {
      resCost = resDetails.cost!;
    }
  }

  void gotoSetResTime() async {
    print('shit');
    if (brandProfileController.carts.isEmpty) {
      String message = brandProfileController.brand.brandIsService == 1
          ? 'من فضلك قم بإضافة الخدمات ثم قم بتحديد وقت الحجز'
          : 'من فضلك قم بإضافة المنتجات ثم قم بتحديد وقت الحجز';
      Get.rawSnackbar(message: message);
      return;
    }
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

  int getNextMultipleOf30(int number) {
    if (number < 30) {
      return 30;
    } else {
      //if its 30 or 60 or 90 save the values as it is
      if (number % 30 == 0) {
        return number;
      } else {
        return ((number ~/ 30) + 1) * 30;
      }
    }
  }

  createRes() async {
    num totalPrice = brandProfileController.totalPrice;
    num taxCost = brandProfileController.taxCost;
    num totalPriceWithTax = totalPrice + taxCost + resCost;
    //
    int duration = 0;
    if (brandProfileController.brand.brandIsService == 0) {
      //if product => duration is saved in resOption
      duration = brandProfileController.selectedResOption.resoptionsDuration!;
    } else {
      //if service => get the total duration from all items in cart
      duration = brandProfileController.totalServiceDuration;
    }

    //duration = getNextMultipleOf30(duration);

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
        withInvitores: withInvitation ? '1' : '0',
        resOption: selectedResOption.resoptionsTitle!,
        status: reviewRes == 0 ? '1' : '0');
    statusRequest = handlingData(response);
    print('create reservation $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('create reservation succeed');
        reservation = Reservation.fromJson(response['data']);
        return reservation;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  checkAllItemsAvailableWithinResOptionSelected() {
    List<dynamic> resItemsId = selectedResOption.itemsRelated!;
    for (int i = 0; i < brandProfileController.carts.length; i++) {
      if (!resItemsId.contains(brandProfileController.carts[i].itemsId)) {
        String warningMessage =
            '${brandProfileController.carts[i].itemsTitle} غير متوفر ضمن تفضيل ${selectedResOption.resoptionsTitle}\n قم بإزالة ${brandProfileController.carts[i].itemsTitle} او قم بتغيير التفضيل';
        print(warningMessage);
        return warningMessage;
      }
    }
    return true;
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
        reviewRes = resDetails.reviewRes!;
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
    print('statusRequest =====$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        resDetails = ResDetails.fromJson(response['data']);
        reviewRes = resDetails.reviewRes!;
        print('resDetails timeout : ${resDetails.timeout}');
        print('success');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getData() {
    if (brandProfileController.isHomeServices) {
      getHomeServices();
    } else {
      getResDetails();
    }
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
