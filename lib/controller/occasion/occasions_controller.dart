import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/occasion.dart';

class OccasionsController extends GetxController {
  MainController mainController = Get.find();

  List<Occasion> occasionsToDisplay = [];
  List<Occasion> acceptedOccasions = [];
  List<Occasion> suspendedOccasions = [];
  List<Occasion> myOccasions = [];
  bool needApprove = false;

  parsingDataFromJsonToDartList(response) {
    List responseOccasoins = response['data'];
    myOccasions = responseOccasoins.map((e) => Occasion.fromJson(e)).toList();
    //make acceptedOccasionList and suspended list
    for (var element in myOccasions) {
      if (element.acceptstatus == 1) {
        acceptedOccasions.add(element);
      } else {
        suspendedOccasions.add(element);
      }
    }
  }

  activeNeedApprove() {
    needApprove = true;
    occasionsToDisplay = suspendedOccasions;
    update();
  }

  inactiveNeedAprrove() {
    needApprove = false;
    occasionsToDisplay = acceptedOccasions;
    update();
  }

  onTapCreate() {
    Get.toNamed(AppRouteName.createOccasion)!.then((value) => refreshScreen());
  }

  refreshScreen() {
    getOccasionFromMainController();
    update();
  }

  onTapOccasionCard(int index) {
    if (occasionsToDisplay[index].creator == 1) {
      Get.toNamed(AppRouteName.editOccasion,
              arguments: occasionsToDisplay[index])!
          .then((value) => refreshScreen());
    } else {
      Get.toNamed(AppRouteName.occasionDetails,
              arguments: occasionsToDisplay[index])!
          .then((value) => refreshScreen());
    }
  }

  getOccasionFromMainController() {
    acceptedOccasions.clear();
    suspendedOccasions.clear();
    myOccasions = List.from(mainController.myOccasions);

    for (var element in myOccasions) {
      if (element.acceptstatus == 1) {
        acceptedOccasions.add(element);
      } else {
        suspendedOccasions.add(element);
      }
    }
    inactiveNeedAprrove();
  }

  @override
  void onInit() {
    getOccasionFromMainController();
    inactiveNeedAprrove();

    super.onInit();
  }
}
