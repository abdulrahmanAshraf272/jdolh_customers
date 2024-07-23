import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/cart_controller.dart';
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

class BrandProfileController extends GetxController {
  String paymentType = '';
  //TODO: Get tax from DB
  double tax = 0.14;
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

  goDisplayAllBchs() {
    Get.offNamed(AppRouteName.allBchs, arguments: brand.brandId);
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
    CartController cartController = Get.put(CartController(bch.bchId!));
    cartController.getCart();
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
        bchid: bch.bchId.toString(), userid: myServices.getUserid());
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseData(response);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  parseData(response) {
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
      tax = (response['taxPercent'] / 100).toDouble();
    }

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

  @override
  void onInit() async {
    super.onInit();
    statusRequest = StatusRequest.loading;
    await receiveArgument();
    getBch();
  }
}
