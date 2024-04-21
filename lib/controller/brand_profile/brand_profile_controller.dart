import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/data_source/remote/cart.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/categories.dart';
import 'package:jdolh_customers/data/models/item.dart';
import 'package:jdolh_customers/data/models/resOption.dart';

class BrandProfileController extends GetxController {
  //Res Product ======================
  int totalServiceDuration = 0;
  num totalPrice = 0;
  num taxCost = 0;

  double averageRate = 0;
  int ratesNo = 0;
  int followingNo = 0;
  int resNo = 0;

  onTapIncrease(int index) {
    //Get quantity and price (off one quantity of cart)
    int quantityNo = carts[index].cartQuantity ?? 1;
    num priceNo = carts[index].cartPrice ?? 0;
    //increase quantity
    quantityNo++;
    //calc new total price
    int newQuantity = quantityNo;
    num newTotalPrice = quantityNo * priceNo;
    //set new quantity and totalPrice
    carts[index].cartQuantity = newQuantity;
    carts[index].cartTotalPrice = newTotalPrice;
    calcResTotalDuration();
    calculateTotalPrice();
    update();
    //set quantity and totalPrice in Db
    changeQuantity(carts[index].cartId!, newQuantity, newTotalPrice);
  }

  onTapDecrease(int index) {
    //Get quantity and price (off one quantity of cart)
    int quantityNo = carts[index].cartQuantity ?? 1;
    num priceNo = carts[index].cartPrice ?? 0;
    if (quantityNo == 1) {
      return;
    }
    //increase quantity
    quantityNo--;
    //calc new total price
    int newQuantity = quantityNo;
    num newTotalPrice = quantityNo * priceNo;
    //set new quantity and totalPrice
    carts[index].cartQuantity = newQuantity;
    carts[index].cartTotalPrice = newTotalPrice;
    calcResTotalDuration();
    calculateTotalPrice();
    update();
    //set quantity and totalPrice in Db
    changeQuantity(carts[index].cartId!, newQuantity, newTotalPrice);
  }

  changeQuantity(int cartid, int quantity, num totalPrice) async {
    var response = await cartData.changeQuantity(
        cartid: cartid.toString(),
        quantity: quantity.toString(),
        totalPrice: totalPrice.toString());
    statusRequestCart = handlingData(response);
    if (statusRequestCart == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('change quantity succeed');
      } else {
        print('change quantity failed');
      }
    }
  }

  deleteCart(int index) async {
    String cartid = carts[index].cartId.toString();
    carts.remove(carts[index]);
    calcResTotalDuration();
    calculateTotalPrice();
    update();
    var response = await cartData.deleteCart(cartid: cartid);
    statusRequestCart = handlingData(response);
    print('delete: $statusRequestCart');
    if (statusRequestCart == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('delete cart success');
      } else {
        statusRequestCart = StatusRequest.failure;
        print('delete failed');
      }
    }
  }

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

  List<Cart> carts = [];

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
    await getCart();
    calcResTotalDuration();
    calculateTotalPrice();
    update();
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

  Future getBchInfo() async {
    var response =
        await brandSearchData.getBchInfo(bchid: bch.bchId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseBchInfo(response);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  parseBchInfo(response) {
    List resOptionsJson = response['resOptions'];

    resOptions = resOptionsJson.map((e) => ResOption.fromJson(e)).toList();
    resOptionsTitles = resOptions.map((e) => e.resoptionsTitle!).toList();
    selectedResOption = resOptions[0];
    initalResOptionTitle = resOptionsTitles.first;
  }

  getCart() async {
    statusRequestCart = StatusRequest.loading;
    update();
    var response = await cartData.getCart(
        userid: myServices.getUserid(), bchid: bch.bchId.toString());
    //await Future.delayed(Duration(seconds: 2));

    statusRequestCart = handlingData(response);
    print('getCart: $statusRequestCart');
    if (statusRequestCart == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('cart success');
        parseCart(response);
      } else {
        statusRequestCart = StatusRequest.failure;
        print('cart failed');
      }
    }
    update();
  }

  parseCart(response) {
    List cartListJson = response['data'];
    carts = cartListJson.map((e) => Cart.fromJson(e)).toList();
  }

  calcResTotalDuration() {
    totalServiceDuration = 0;
    for (int i = 0; i < carts.length; i++) {
      totalServiceDuration += carts[i].itemsDuration ?? 0;
    }
  }

  calculateTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < carts.length; i++) {
      totalPrice += carts[i].cartTotalPrice!;
    }
    taxCost = totalPrice * 0.15;
  }

  gotoDisplayWorktime() {
    Get.toNamed(AppRouteName.displayWorktime, arguments: bchWorktime);
  }

  Future getBch() async {
    var response = await brandSearchData.getBch(
        bchid: bch.bchId.toString(), userid: myServices.getUserid());
    statusRequest = handlingData(response);
    update();
    print(response);
    print('get Bch status ${statusRequest}');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseData(response);
      } else {
        print('get bch failed');
        statusRequest = StatusRequest.failure;
      }
    }
    //update();
  }

  parseData(response) {
    followingNo = response['followingNo'];
    ratesNo = response['ratesNo'];
    averageRate = response['averageRate'].toDouble();
    resNo = response["resNo"];

    isFollowing = response['isFollowing'];
    List categoriesJson = response['categories'];
    List itemsJson = response['items'];
    var worktimeJson = response['worktime'];

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
    } else {
      followingNo = followingNo - 1;
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
    Future<void> bothFinished = Future.wait([getBch(), getBchInfo()]);

    bothFinished.then((_) {
      update();
      print('two of them are finished');
    });

    //getCart();
  }
}
