import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  }
}
