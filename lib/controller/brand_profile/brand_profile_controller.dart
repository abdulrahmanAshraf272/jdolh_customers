import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/cart_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_home_services_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_parent_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_product_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_service_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_subscribtion.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/data_source/remote/cart.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/categories.dart';
import 'package:jdolh_customers/data/models/item.dart';
import 'package:jdolh_customers/data/models/policy.dart';
import 'package:jdolh_customers/data/models/resOption.dart';
import 'package:jdolh_customers/data/models/user.dart';
import 'package:jdolh_customers/data/models/user_rate.dart';

class BrandProfileController extends GetxController {
  String paymentType = '';
  //TODO: Get tax from DB
  double tax = 0.15;
  double resTaxPercent = 0;
//0 => items, 1 => resProduct, 2 => resService, 3=> HomeService
  int subscreen = 0;
  late Brand brand;
  late Bch bch;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCart = StatusRequest.loading;

  BrandSearchData brandSearchData = BrandSearchData(Get.find());
  CartData cartData = CartData(Get.find());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());

  //List<Cart> carts = [];

  bool isHomeServices = false;

  //int counter = 0;

  List<MyCategories> categories = [];
  List<Item> items = [];
  List<Item> itemsToDisplay = [];
  int selectedIndexCategory = 0;

  List<UserRate> rates = [];
  List<User> scheduledUsers = [];

  List<ResOption> resOptions = [];
  List<String> resOptionsTitles = [];
  late ResOption selectedResOption;
  String initalResOptionTitle = '';
  double averageRate = 0;
  int ratesNo = 0;
  int followingNo = 0;
  int resNo = 0;

  late Policy resPolicy;
  late Policy billPolicy;

  late BchWorktime bchWorktime;
  bool isFollowing = false;

  onTapRates() {
    Get.toNamed(AppRouteName.rates, arguments: rates);
  }

  onTapScheduled() {
    Get.toNamed(AppRouteName.scheduledUsers, arguments: scheduledUsers);
  }

  goDisplayAllBchs() async {
    final result = await Get.toNamed(AppRouteName.allBchs,
        arguments: {"brandid": brand.brandId, "isHomeService": isHomeServices});
    if (result != null) {
      changeBch(result);
    }
  }

  changeBch(result) {
    statusRequest = StatusRequest.loading;
    update();

    brand = result['brand'];
    bch = result['bch'];
    bch.bchBrandid = brand.brandId;
    subscreen = 0;
    if (isHomeServices) {
      Get.delete<ResHomeServicesController>();
    } else if (brand.brandIsService == 1) {
      Get.delete<ResServiceConltroller>();
    } else {
      Get.delete<ResProductController>();
    }
    getBch();
  }

  selectResOption(String resOptionTitle) {
    selectedResOption = resOptions
        .firstWhere((element) => element.resoptionsTitle == resOptionTitle);
    update();
  }

  displayResSubscreen() async {
    if (isHomeServices) {
      subscreen = 3;
    } else if (brand.brandIsService == 1) {
      subscreen = 2;
    } else {
      subscreen = 1;
    }
    update();
    CartController cartController = Get.put(CartController());
    cartController.getCart(bch.bchId!);
  }

  diplayItemsSubscreen() {
    subscreen = 0;
    update();
  }

  onTapCategory(int index) {
    selectedIndexCategory = index;

    itemsToDisplay.clear();
    int categoryIdSelected = categories[index].id!;
    print('category selected: $categoryIdSelected');

    for (int i = 0; i < items.length; i++) {
      if (items[i].itemsCategoriesid == categoryIdSelected) {
        itemsToDisplay.add(items[i]);
      }
    }
    update();
  }

  onTapItem(int index) {
    Get.toNamed(AppRouteName.itemsDetails,
        arguments: {"item": itemsToDisplay[index], "bch": bch, "brand": brand});
  }

  gotoDisplayWorktime() {
    Get.toNamed(AppRouteName.displayWorktime, arguments: bchWorktime);
  }

  getBch() async {
    var response = await brandSearchData.getBch(
        bchid: bch.bchId.toString(),
        userid: myServices.getUserid(),
        brandid: bch.bchBrandid.toString());
    statusRequest = handlingData(response);
    print('status get bch: $statusRequest');
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseData(response);
      } else {
        print('failure message: ${response['message']}');
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  parseData(response) {
    resetData();
    //=== Policies ===//
    resPolicy = Policy.fromJsonRes(response['policies']);
    billPolicy = Policy.fromJsonBill(response['policies']);
    print('resPolicy: ${resPolicy.title}');
    print('billPolicy: ${billPolicy.title}');
    if (billPolicy.id == 4) {
      paymentType = 'R';
    } else {
      paymentType = 'RB';
    }

    // ==== Rates ====//
    List ratesData = response['rates'];
    rates = ratesData.map((e) => UserRate.fromJson(e)).toList();

    //==== Scheduled ====/
    List scheduledUsersData = response['scheduledUsers'];
    scheduledUsers = scheduledUsersData.map((e) => User.fromJson(e)).toList();

    //=== ResOption ===//
    List resOptionsJson = response['resOptions'];
    resOptions = resOptionsJson.map((e) => ResOption.fromJson(e)).toList();
    resOptionsTitles = resOptions.map((e) => e.resoptionsTitle!).toList();
    selectedResOption = resOptions[0];
    initalResOptionTitle = resOptionsTitles.first;

    //====== following, rate ======//
    followingNo = response['followingNo'];
    ratesNo = response['ratesNo'];
    if (response['averageRate'] != null) {
      averageRate = response['averageRate'].toDouble();
    }
    resNo = response["resNo"];

    isFollowing = response['isFollowing'];
    List categoriesJson = response['categories'];
    List itemsJson = response['items'];
    var worktimeJson = response['worktime'];

    if (response['taxPercent'] != null) {
      double t = double.parse(response['taxPercent']);
      resTaxPercent = t / 100;
    }

    if (response['billTax'] != null) {
      double t = double.parse(response['billTax']);
      tax = t / 100;
    }

    print('resTax: $resTaxPercent');
    print('billTax: $tax');

    bchWorktime = BchWorktime.fromJson(worktimeJson);

    categories = categoriesJson.map((e) => MyCategories.fromJson(e)).toList();
    items = itemsJson.map((e) => Item.fromJson(e)).toList();

    //I only get the items that is items_active = 1 from backend

    //Dispay Items for first category
    int categoryIdSelected = categories[0].id!;
    for (int i = 0; i < items.length; i++) {
      if (items[i].itemsCategoriesid == categoryIdSelected) {
        itemsToDisplay.add(items[i]);
      }
    }
  }

  followUnfollow() async {
    isFollowing = !isFollowing;
    if (isFollowing) {
      followingNo = followingNo + 1;
      NotificationSubscribtion.followBchSubcribeToTopic(bch.bchId);
    } else {
      followingNo = followingNo - 1;
      NotificationSubscribtion.unfollowBchSubcribeToTopic(bch.bchId);
    }
    update();
    var response = await followUnfollowData.followBch(
        bchid: bch.bchId.toString(), userid: myServices.getUserid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('follow success');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  receiveArgument() async {
    if (Get.arguments != null) {
      if (Get.arguments['fromActivity'] != null) {
        int bchid = Get.arguments['bchid'];
        await getBrandBch(bchid);
      } else if (Get.arguments is int) {
        int bchid = Get.arguments;
        await getBrandBch(bchid);
      } else {
        try {
          brand = Get.arguments['brand'];
          bch = Get.arguments['bch'];
          if (Get.arguments['isHomeService'] != null) {
            isHomeServices = Get.arguments['isHomeService'];
            print('isHomeService: $isHomeServices');
          }
        } catch (e) {
          print('error get the data previus page');
        }
      }
    }

    print('bchid: ${bch.bchId}');
  }

  getBrandBch(int bchid) async {
    // statusRequest = StatusRequest.loading;
    // update();
    var response = await brandSearchData.getBrandBch(bchid: bchid.toString());
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        var data = response['data'];

        brand = Brand.fromJson(data);

        bch = Bch.fromJson(data);
        bchid = bch.bchId!;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
    print('======$statusRequest');
  }

  resetData() {
    resOptions.clear();
    resOptionsTitles.clear();
    items.clear();
    itemsToDisplay.clear();
    categories.clear();
    rates.clear();
    scheduledUsers.clear();
  }

  @override
  void onInit() async {
    super.onInit();
    statusRequest = StatusRequest.loading;
    await receiveArgument();
    getBch();
  }
}
