import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/brand_subtype.dart';
import 'package:jdolh_customers/data/models/brand_type.dart';

class ReservationSearchController extends GetxController {
  StatusRequest statusRequestType = StatusRequest.none;
  StatusRequest statusRequest = StatusRequest.none;
  BrandSearchData brandSearchData = BrandSearchData(Get.find());

  BrandType? selectedType;
  BrandSubtype? selectedSubtype;

  List<BrandType> brandTypesDisplay = [];
  List<BrandType> brandTypesWithoutProduct = [];
  List<BrandType> brandTypes = [];

  List<BrandSubtype> brandSubtypes = [];

  List<String> brandTypesString = [];
  List<String> brandSubtypesToDisplay = [];
  String city = cities[0];
  //To solve the problem of the subtype .
  String? selectedValue;
  String? selectedValueType;

  List<Brand> brands = [];
  List<Bch> bchs = [];

  onTapDisplayOnTap() {
    if (bchs.isNotEmpty) {
      List<Marker> markers = [];
      for (int i = 0; i < bchs.length; i++) {
        double lat = double.parse(bchs[i].bchLat!);
        double lng = double.parse(bchs[i].bchLng!);
        LatLng latLng = LatLng(lat, lng);

        Marker marker = Marker(markerId: MarkerId("$i"), position: latLng);
        markers.add(marker);
      }

      Get.toNamed(AppRouteName.diplayLocation, arguments: markers);
    }
  }

  bool isHomeServices = false;
  setIsHomeService(bool value) {
    isHomeServices = value;
    print(isHomeServices);
    brands.clear();
    bchs.clear();

    if (isHomeServices) {
      brandTypesDisplay = List.from(brandTypesWithoutProduct);
    } else {
      brandTypesDisplay = List.from(brandTypes);
    }

    selectedValue = null;
    selectedSubtype = null;
    selectedValueType = null;
    selectedType = null;
    brandTypesString.clear();
    for (int i = 0; i < brandTypesDisplay.length; i++) {
      brandTypesString.add(brandTypesDisplay[i].type!);
    }

    update();
  }

  onTapCard(int index) {
    Get.toNamed(AppRouteName.brandProfile, arguments: {
      "brand": brands[index],
      "bch": bchs[index],
      "isHomeService": isHomeServices
    });
  }

  searchBrand() async {
    String subtype = '';
    String type = '';

    if (selectedType != null) {
      type = selectedType!.type ?? '';
    }

    if (selectedSubtype != null) {
      subtype = selectedSubtype!.subtype ?? '';
    }

    statusRequest = StatusRequest.loading;
    update();
    var response = await brandSearchData.searchBrand(city, type, subtype);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseSearchResults(response);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
    print('======$statusRequest');
  }

  parseSearchResults(response) {
    brands.clear();
    bchs.clear();
    List data = response['data'];
    brands = data.map((e) => Brand.fromJson(e)).toList();
    bchs = data.map((e) => Bch.fromJson(e)).toList();

    print('bch length: ${bchs.length}');
    if (isHomeServices) {
      List<Brand> brandsHomeService = [];
      List<Bch> bchsHomeService = [];
      //Remove all bch that is note home service active.
      for (int i = 0; i < bchs.length; i++) {
        if (bchs[i].bchHomeAvailable == 1) {
          brandsHomeService.add(brands[i]);
          bchsHomeService.add(bchs[i]);
        }
      }

      brands = List.from(brandsHomeService);
      bchs = List.from(bchsHomeService);
    }

    update();
  }

  getBrandTypesAndSubtypes() async {
    statusRequestType = StatusRequest.loading;
    update();
    var response = await brandSearchData.getTypesAndSubtypes();
    statusRequestType = handlingData(response);
    update();
    if (statusRequestType == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseTypesAndSubtypes(response);
      } else {
        Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    } //
  }

  parseTypesAndSubtypes(response) {
    brandTypes.clear();
    brandSubtypes.clear();

    List typesJson = response['types'];
    List subtypesJson = response['subtypes'];

    brandTypes = typesJson.map((e) => BrandType.fromJson(e)).toList();
    brandSubtypes = subtypesJson.map((e) => BrandSubtype.fromJson(e)).toList();

    brandTypesWithoutProduct
        .addAll(brandTypes.where((element) => element.isService == 1));

    brandTypesDisplay = List.from(brandTypes);

    for (int i = 0; i < brandTypesDisplay.length; i++) {
      brandTypesString.add(brandTypesDisplay[i].type!);
    }

    update();
  }

  setSelectedBrandType(String? value) {
    if (value != null) {
      selectedType =
          brandTypesDisplay.firstWhere((element) => element.type == value);

      selectedValue = null;
      selectedSubtype = null;
      brandSubtypesToDisplay.clear();
      for (int i = 0; i < brandSubtypes.length; i++) {
        if (brandSubtypes[i].typeId == selectedType!.id) {
          brandSubtypesToDisplay.add(brandSubtypes[i].subtype!);
        }
      }
      update();
      print(selectedType!.type);
    }
  }

  setSelectedSubtypeType(String? value) {
    if (value != null) {
      selectedSubtype =
          brandSubtypes.firstWhere((element) => element.subtype == value);
      print(selectedSubtype!.subtype);
    }
  }

  @override
  void onInit() {
    getBrandTypesAndSubtypes();
    super.onInit();
  }
}
