import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/rounding.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/cart.dart';
import 'package:jdolh_customers/data/models/cart.dart';

class CartController extends GetxController {
  int bchid;
  CartController(this.bchid);

  StatusRequest statusRequest = StatusRequest.none;
  int totalServiceDuration = 0;
  double totalPrice = 0;
  double taxCost = 0;
  List<Cart> carts = [];
  MyServices myServices = Get.find();
  CartData cartData = CartData(Get.find());

  onTapIncrease(int index) {
    //Get quantity and price (off one quantity of cart)
    int quantityNo = carts[index].cartQuantity ?? 1;
    double priceNo = carts[index].cartPrice ?? 0;
    //increase quantity
    quantityNo++;
    //calc new total price
    int newQuantity = quantityNo;
    double newTotalPrice = quantityNo * priceNo;
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
    double priceNo = carts[index].cartPrice ?? 0;
    if (quantityNo == 1) {
      return;
    }
    //increase quantity
    quantityNo--;
    //calc new total price
    int newQuantity = quantityNo;
    double newTotalPrice = quantityNo * priceNo;
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
    StatusRequest statusRequestCart = handlingData(response);
    if (statusRequestCart == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('change quantity succeed');
      } else {
        print('change quantity failed');
      }
    }
  }

  onTapDeleteCart(int index) async {
    String cartid = carts[index].cartId.toString();
    carts.remove(carts[index]);
    calcResTotalDuration();
    calculateTotalPrice();
    update();
    deleteCart(cartid);
  }

  clearCart() {
    carts.clear();
    update();
  }

  deleteCart(String cartid) async {
    var response = await cartData.deleteCart(cartid: cartid);
    StatusRequest statusDelete = handlingData(response);
    print('delete: $statusDelete');
    if (statusDelete == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('delete cart success');
      } else {
        statusDelete = StatusRequest.failure;
        print('delete failed');
      }
    }
  }

  getCart() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.getCart(
        userid: myServices.getUserid(), bchid: bchid.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseCart(response);
        calcResTotalDuration();
        calculateTotalPrice();
      } else {
        statusRequest = StatusRequest.failure;
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
    taxCost = roundTwoDecimal(totalPrice * 0.14);
  }
}
