import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/cart.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/resOption.dart';

class ResParentController extends GetxController {
  StatusRequest statusRequestCart = StatusRequest.none;
  CartData cartData = CartData(Get.find());
  MyServices myServices = Get.find();
  BrandProfileController brandProfileController = Get.find();

  List<Cart> carts = [];
  List<ResOption> resOptions = [];
  List<String> resOptionsTitles = [];
  late ResOption selectedResOption;
  selectResOption(String resOptionTitle) {
    selectedResOption = resOptions
        .firstWhere((element) => element.resoptionsTitle == resOptionTitle);
  }

  String totalServiceDuration = '-';

  getCart() async {
    statusRequestCart = StatusRequest.loading;
    update();
    var response = await cartData.getCart(
        userid: myServices.getUserid(),
        bchid: brandProfileController.bch.bchId.toString());
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
    print('cart: ${carts.length}');
  }

  //================================

  calcResTotalDuration() {
    if (brandProfileController.carts.isEmpty) {
      totalServiceDuration = '-';
    } else {
      int totalDuration = 0;
      brandProfileController.carts.forEach((element) {
        totalDuration += element.itemsDuration ?? 0;
      });
      totalServiceDuration = totalDuration.toString();
    }
    update();
  }

  @override
  void onInit() {
    //Get ResOption
    resOptions = List.from(brandProfileController.resOptions);
    resOptionsTitles = List.from(brandProfileController.resOptionsTitles);
    selectedResOption = brandProfileController.selectedResOption;
    super.onInit();
  }
}
