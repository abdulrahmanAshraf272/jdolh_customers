import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/models/ioption_element.dart';
import 'package:jdolh_customers/data/models/item.dart';
import 'package:jdolh_customers/data/models/item_option.dart';

class ItemsDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  BrandSearchData brandSearchData = BrandSearchData(Get.find());
  late Item item;
  List<ItemOption> itemOptions = [];
  String desc = '';
  String shortDesc = '';

  List<IOptionElement> elementSelected = [];

  int totalPrice = 0;

  onTapAddToCart() {
    if (checkBasicOptionSelected()) {
      desc = extractDesc();
      print('desc: $desc');
      shortDesc = extractShortDesc();
      print('shortDesc $shortDesc');
      print('all basic elements selected');
    }
  }

  String extractDesc() {
    String desc = '';

    for (int i = 0; i < elementSelected.length; i++) {
      desc += '${elementSelected[i].name}: price = ${elementSelected[i].price}';
      if (i < elementSelected.length - 1) {
        desc += '\n';
      }
    }

    return desc;
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
    totalPrice = 0;
    totalPrice = item.itemsPrice ?? 0;
    for (int i = 0; i < elementSelected.length; i++) {
      totalPrice += elementSelected[i].price ?? 0;
    }
    update();
  }

  getItemOptionsWithElements() async {
    if (item.itemsWithOptions == 0) {
      return;
    }

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
      item = Get.arguments;
      totalPrice = item.itemsPrice ?? 0;
    } else {
      print("item didn't send to itemsDetails");
    }
  }

  @override
  void onInit() {
    receiveArgument();
    getItemOptionsWithElements();
    super.onInit();
  }
}
