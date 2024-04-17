import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class FinishedOccasionsController extends GetxController {
  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  List<Occasion> occasionsToDisplay = [];
  ///////
  List<Occasion> myOccasions = [];

  onTapOccasionCard(int index) {
    Get.toNamed(AppRouteName.occasionDetails,
        arguments: occasionsToDisplay[index]);
  }

  getMyOccasion() async {
    startLoadingAndClearLists();
    var response = await occasionData
        .viewOccasions(myServices.sharedPreferences.getString("id")!);
    await Future.delayed(const Duration(seconds: lateDuration));
    statusRequest = handlingData(response);
    update();
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parsingDataFromJsonToDartList(response);
        print('occasions: ${myOccasions.length}');
      } else {
        //statusRequest = StatusRequest.failure;
      }
    }
  }

  startLoadingAndClearLists() {
    statusRequest = StatusRequest.loading;
    update();
    myOccasions.clear();
    occasionsToDisplay.clear();
  }

  parsingDataFromJsonToDartList(response) {
    List responseOccasoins = response['data'];
    myOccasions = responseOccasoins.map((e) => Occasion.fromJson(e)).toList();
    occasionsToDisplay = filterAndOrderOccasionInPast(myOccasions);
  }

  List<Occasion> filterAndOrderOccasionInPast(
    List<Occasion> myOccasions,
  ) {
    final now = DateTime.now();
    final currentDateTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);

    List<Occasion> pastOccasions = [];

    for (var occasion in myOccasions) {
      DateTime occasionDateTime =
          DateTime.parse('${occasion.occasionDate} ${occasion.occasionTime}');
      if (occasionDateTime.isBefore(currentDateTime)) {
        pastOccasions.add(occasion);
      }
    }

    pastOccasions.sort((a, b) {
      DateTime aDateTime =
          DateTime.parse('${a.occasionDate} ${a.occasionTime}');
      DateTime bDateTime =
          DateTime.parse('${b.occasionDate} ${b.occasionTime}');
      return bDateTime.compareTo(aDateTime); // Sort later first
    });

    return pastOccasions;
  }

  String timeInAmPm(int index) {
    String timeIn24 = occasionsToDisplay[index].occasionTime!;
    final parts = timeIn24.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final dateTime = DateTime(0, 0, 0, hour, minute);
    final formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }

  @override
  void onInit() async {
    getMyOccasion();
    super.onInit();
  }
}
