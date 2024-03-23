import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/data_source/remote/cart.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/ioption_element.dart';
import 'package:jdolh_customers/data/models/item.dart';
import 'package:jdolh_customers/data/models/item_option.dart';

class ItemsDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  BrandSearchData brandSearchData = BrandSearchData(Get.find());
  MyServices myServices = Get.find();
  CartData cartData = CartData(Get.find());
  late Item item;
  late Bch bch;
  late Brand brand;
  List<ItemOption> itemOptions = [];
  String desc = '';
  String shortDesc = '';
  int discountAmount = 0;
  int quantity = 1;

  List<IOptionElement> elementSelected = [];
  num itemPrice = 0;
  num itemPriceAfterDiscount = 0;

  num totalPrice = 0;

  num optionsPrice = 0;

  onTapIncrease() {
    quantity++;
    totalPrice = (itemPriceAfterDiscount + optionsPrice) * quantity;
    update();
  }

  onTapDecrease() {
    if (quantity == 1) return;
    quantity--;
    totalPrice = (itemPriceAfterDiscount + optionsPrice) * quantity;
    update();
  }

  Future<bool> onTapAddToCart() async {
    if (checkBasicOptionSelected()) {
      desc = extractDesc();
      shortDesc = extractShortDesc();

      bool isAddDone = await addCart();
      return isAddDone;
    }
    return false;
  }

  Future<bool> addCart() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.addCart(
        userid: myServices.getUserid(),
        bchid: bch.bchId.toString(),
        itemid: item.itemsId.toString(),
        price: itemPriceAfterDiscount.toString(),
        totalPrice: totalPrice.toString(),
        discount: discountAmount.toString(),
        desc: desc,
        shortDesc: shortDesc,
        quantity: quantity.toString());
    statusRequest = handlingData(response);
    update();
    print('addCart: $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('cart success');
        return true;
      } else {
        statusRequest = StatusRequest.failure;
        print('cart failed');
      }
    }
    return false;
  }

  String extractDesc() {
    String desc = '';

    for (int i = 0; i < elementSelected.length; i++) {
      String optionTitle = getOptionTitle(elementSelected[i]);

      desc +=
          '$optionTitle: ${elementSelected[i].name}, price = ${elementSelected[i].price} SAR';
      if (i < elementSelected.length - 1) {
        desc += '\n';
      }
    }

    return desc;
  }

  String getOptionTitle(IOptionElement element) {
    for (int i = 0; i < itemOptions.length; i++) {
      List<IOptionElement> elements = itemOptions[i].elements!;

      for (int j = 0; j < elements.length; j++) {
        if (elements[j] == element) {
          return itemOptions[i].title!;
        }
      }
    }
    return '';
  }

  String extractShortDesc() {
    List<String> names =
        elementSelected.map((element) => element.name ?? '').toList();
    return names.join(', ');
  }

  checkBasicOptionSelected() {
    for (int i = 0; i < itemOptions.length; i++) {
      if (itemOptions[i].isBasic == 1) {
        bool userSelected = containsAny(itemOptions[i].elements!);
        if (!userSelected) {
          Get.rawSnackbar(
              message: "من فضلك قم باختيار '${itemOptions[i].title}'");
          return false;
        }
      }
    }
    return true;
  }

  bool containsAny(List<IOptionElement> elements) {
    for (var selectedElement in elementSelected) {
      if (elements.contains(selectedElement)) {
        return true;
      }
    }
    return false;
  }

  void clearItemOptionElements(IOptionElement element) {
    elementSelected.removeWhere((e) => e.itemOptionId == element.itemOptionId);
  }

  updateTotalPrice() {
    optionsPrice = 0;
    for (int i = 0; i < elementSelected.length; i++) {
      optionsPrice += elementSelected[i].price ?? 0;
    }
    totalPrice = (itemPriceAfterDiscount + optionsPrice) * quantity;
    update();
  }

  getItemOptionsWithElements() async {
    if (item.itemsWithOptions == 0) {
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var response = await brandSearchData.getItemOptionsWithElements(
        itemId: item.itemsId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        parseData(response);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void parseData(response) {
    List dataJsonList = response['data'];

    for (int i = 0; i < dataJsonList.length; i++) {
      // parse itemOption data
      ItemOption itemOption = ItemOption.fromJson(dataJsonList[i]);

      // Get Elements
      List<IOptionElement> elementsTemp = [];
      List elemensJsonList = dataJsonList[i]['elements'];
      elementsTemp =
          elemensJsonList.map((e) => IOptionElement.fromJson(e)).toList();

      // Inject elements into itemOption
      itemOption.elements = List.from(elementsTemp);

      itemOptions.add(itemOption);
    }

    // Sort itemOptions by priceDep, placing items with priceDep == 1 first
    itemOptions.sort((a, b) {
      if (a.priceDep == 1 && b.priceDep != 1) {
        return -1; // Place itemOption with priceDep == 1 before other options
      } else if (a.priceDep != 1 && b.priceDep == 1) {
        return 1; // Place itemOption with priceDep != 1 after other options
      } else {
        return 0; // Maintain the original order for other cases
      }
    });

    print('${itemOptions[0].title}');
  }

  receiveArgument() {
    if (Get.arguments != null) {
      item = Get.arguments['item'];
      bch = Get.arguments['bch'];
      brand = Get.arguments['brand'];
      getPriceAndApplyDiscount();
    } else {
      print("item didn't send to itemsDetails");
    }
  }

  getPriceAndApplyDiscount() {
    //Get item price
    itemPrice = item.itemsPrice ?? 0;
    itemPriceAfterDiscount = itemPrice;
    //Get Discount amount
    if (item.itemsDiscount != 0) {
      discountAmount = item.itemsDiscount!;
    } else if (item.itemsDiscountPercentage != 0) {
      discountAmount =
          (itemPrice * (item.itemsDiscountPercentage! / 100)).toInt();
    }
    //Get item price after discount
    itemPriceAfterDiscount = itemPrice - discountAmount;
    //set Total price
    totalPrice = itemPriceAfterDiscount;
  }

  @override
  void onInit() {
    receiveArgument();
    getItemOptionsWithElements();
    super.onInit();
  }
}
