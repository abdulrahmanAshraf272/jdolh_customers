import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/occasion.dart';

class OccasionsController extends GetxController {
  ValuesController valuesController = Get.find();
  List<Occasion> occasionsToDisplay = [];
  bool needApprove = false;

  activeNeedApprove() {
    needApprove = true;
    occasionsToDisplay = valuesController.suspendedOccasions;
    update();
  }

  inactiveNeedAprrove() {
    needApprove = false;
    occasionsToDisplay = valuesController.acceptedOccasions;
    update();
  }

  onTapCreate() {
    Get.toNamed(AppRouteName.createOccasion)!.then((value) => refreshScreen());
  }

  refreshScreen() {
    //getOccasionFromMainController();
    inactiveNeedAprrove();
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

  String formatDateTime(String inputDateTime) {
    DateTime dateTime = DateTime.parse(inputDateTime);
    String formattedDateTime = DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
    return formattedDateTime;
  }

  String displayFormateDateInCard(int index) {
    String dateFormated =
        formatDateTime(occasionsToDisplay[index].occasionDatetime.toString());
    return dateFormated;
  }

  @override
  void onInit() {
    //getOccasionFromMainController();
    inactiveNeedAprrove();

    super.onInit();
  }
}
