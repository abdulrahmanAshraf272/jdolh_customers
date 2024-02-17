import 'package:get/get.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/data/models/occasion.dart';

class ApptController extends GetxController {
  MainController mainController = Get.find();
  List<Occasion> occasionToDisplay = [];
  List<Occasion> acceptedOccasion = [];
  List<Occasion> suspendedOccasion = [];
  bool needApprove = false;

  activeNeedApprove() {
    needApprove = true;
    occasionToDisplay = suspendedOccasion;
    update();
  }

  inactiveNeedAprrove() {
    needApprove = false;
    occasionToDisplay = acceptedOccasion;
    update();
  }

  @override
  void onInit() {
    acceptedOccasion = List.from(mainController.acceptedOccasions);
    suspendedOccasion = List.from(mainController.suspendedOccasions);
    occasionToDisplay = acceptedOccasion;
    super.onInit();
  }
}
