import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/res_service_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/data_source/remote/cart.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/categories.dart';
import 'package:jdolh_customers/data/models/item.dart';
import 'package:jdolh_customers/data/models/resOption.dart';

class BrandProfileController extends GetxController {
  //Res Product ======================
  TextEditingController extraSeats = TextEditingController();
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

  checkAllItemsAvailableWithinResOptionSelected() {
    List<dynamic> resItemsId = selectedResOption.itemsRelated!;
    for (int i = 0; i < carts.length; i++) {
      if (!resItemsId.contains(carts[i].itemsId)) {
        String warningMessage =
            '${carts[i].itemsTitle} غير متوفر ضمن تفضيل ${selectedResOption.resoptionsTitle}\n قم بإزالة ${carts[i].itemsTitle} او قم بتغيير التفضيل';
        print(warningMessage);
        return warningMessage;
      }
    }
    return true;
  }

  onTapConfirmReservation() {
    if (carts.isEmpty) {
      Get.rawSnackbar(message: 'السلة فارغة!');
      return;
    }
    print('confirm reservation');
  }

  int subscreen = 0; //0 => items, 1 => resProduct, 2 => resService
  late Brand brand;
  late Bch bch;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCart = StatusRequest.loading;

  BrandSearchData brandSearchData = BrandSearchData(Get.find());
  CartData cartData = CartData(Get.find());

  List<Cart> carts = [];

  int counter = 0;

  List<MyCategories> categories = [];
  List<Item> items = [];
  List<Item> itemsToDisplay = [];
  late ResOption selectedResOption;

  int selectedIndexCategory = 0;

  List<ResOption> resOptions = [];
  List<String> resOptionsTitles = [];
  String initalResOptionTitle = '';

  late BchWorktime bchWorktime;

  selectResOption(String resOptionTitle) {
    selectedResOption = resOptions
        .firstWhere((element) => element.resoptionsTitle == resOptionTitle);
    update();
  }

  displayResSubscreen() async {
    if (brand.brandIsService == 1) {
      subscreen = 2;
    } else {
      subscreen = 1;
    }
    update();
    getCart();
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

  getBchInfo() async {
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
    await Future.delayed(Duration(seconds: 2));

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

  deleteCart(int index) async {
    String cartid = carts[index].cartId.toString();
    update();
    carts.remove(carts[index]);
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

  parseCart(response) {
    List cartListJson = response['data'];
    carts = cartListJson.map((e) => Cart.fromJson(e)).toList();
  }

  getBch() async {
    var response = await brandSearchData.getBch(bchid: bch.bchId.toString());
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
    List categoriesJson = response['categories'];
    List itemsJson = response['items'];
    var worktimeJson = response['worktime'];

    bchWorktime = BchWorktime.fromJson(worktimeJson);

    categories = categoriesJson.map((e) => MyCategories.fromJson(e)).toList();
    items = itemsJson.map((e) => Item.fromJson(e)).toList();

    //Dispay Items for first category
    int categoryIdSelected = categories[0].id!;
    for (int i = 0; i < items.length; i++) {
      if (items[i].itemsCategoriesid == categoryIdSelected) {
        itemsToDisplay.add(items[i]);
      }
    }
  }

  receiveArgument() {
    try {
      brand = Get.arguments['brand'];
      bch = Get.arguments['bch'];
    } catch (e) {
      print('error get the data previus page');
    }
  }

  @override
  void onInit() {
    super.onInit();
    receiveArgument();
    getBch();
    getBchInfo();
    //getCart();
  }
}
