import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/services/services.dart';

class MoreController extends GetxController {
  MyServices myServices = Get.find();
  logout() {
    Get.offAllNamed(AppRouteName.login);
    myServices.sharedPreferences.setString("step", "1");
  }
}
