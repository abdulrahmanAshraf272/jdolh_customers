import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/categories.dart';
import 'package:jdolh_customers/data/models/item.dart';
import 'package:jdolh_customers/data/models/resOption.dart';

class BrandProfileController extends GetxController {
  int subscreen = 0; //0 => items, 1 => resProduct, 2 => resService
  late Brand brand;
  late Bch bch;
  StatusRequest statusRequest = StatusRequest.none;
  BrandSearchData brandSearchData = BrandSearchData(Get.find());

  List<MyCategories> categories = [];
  List<Item> items = [];
  List<Item> itemsToDisplay = [];

  int selectedIndexCategory = 0;

  displayResSubscreen() {
    if (brand.brandIsService == 1) {
      subscreen = 2;
    } else {
      subscreen = 1;
    }
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
    Get.toNamed(AppRouteName.itemsDetails, arguments: itemsToDisplay[index]);
  }

  getBchData() async {
    statusRequest = StatusRequest.loading;
    update();
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
    getBchData();
  }
}
