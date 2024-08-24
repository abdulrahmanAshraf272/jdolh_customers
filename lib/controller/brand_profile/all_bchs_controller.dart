import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';

class AllBchsController extends GetxController {
  bool isHomeServices = false;
  late int brandid;
  StatusRequest statusRequest = StatusRequest.none;
  BrandSearchData brandSearchData = BrandSearchData(Get.find());
  List<Brand> brands = [];
  List<Bch> bchs = [];

  onTapCard(int index) {
    print('bchid : ${bchs[index].bchId}');
    //return;
    //Get.back();
    //Get.until((route) => Get.currentRoute == AppRouteName.mainScreen);
    //Get.offAllNamed(AppRouteName.mainScreen);

    Get.back(result: {"brand": brands[index], "bch": bchs[index]});

    // Get.back();
    // Get.back();
    // Get.toNamed(AppRouteName.brandProfile, arguments: {
    //   "brand": brands[index],
    //   "bch": bchs[index],
    //   "isHomeService": isHomeServices
    // });
  }

  getAllBchs() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await brandSearchData.getAllBchs(brandid: brandid.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseSearchResults(response);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  parseSearchResults(response) {
    List data = response['data'];
    brands = data.map((e) => Brand.fromJson(e)).toList();
    bchs = data.map((e) => Bch.fromJson(e)).toList();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      brandid = Get.arguments['brandid'];
      isHomeServices = Get.arguments['isHomeService'];
    }
    getAllBchs();
    super.onInit();
  }
}
