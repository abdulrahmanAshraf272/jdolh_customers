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

class OccasionsController extends GetxController {
  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController excuse = TextEditingController();

  List<Occasion> occasionsToDisplay = [];
  ///////
  List<Occasion> myOccasions = [];
  List<Occasion> acceptedOccasions = [];
  List<Occasion> suspendedOccasions = [];

  onTapOccasionCard(int index) {
    if (occasionsToDisplay[index].creator == 1) {
      Get.toNamed(AppRouteName.editOccasion,
              arguments: occasionsToDisplay[index])!
          .then((value) => getMyOccasion());
    } else {
      Get.toNamed(AppRouteName.occasionDetails,
              arguments: occasionsToDisplay[index])!
          .then((value) {
        if (needApprove) {
          activeNeedApprove();
        } else {
          inactiveNeedAprrove();
        }
      });
    }
  }

  ////

  bool needApprove = false;
  activeNeedApprove() async {
    await getMyOccasion();
    needApprove = true;
    occasionsToDisplay = List.from(suspendedOccasions);
    update();
  }

  inactiveNeedAprrove() async {
    await getMyOccasion();
    needApprove = false;
    occasionsToDisplay = List.from(acceptedOccasions);
    update();
  }

  onTapCreate() {
    Get.toNamed(AppRouteName.createOccasion)!
        .then((value) => resetAcceptedAndSuspendedList());
  }

  refreshScreen() {
    inactiveNeedAprrove();
    update();
  }

  // String displayFormateDateInCard(int index) {
  //   String dateFormated =
  //       formatDateTime(occasionsToDisplay[index].occasionDatetime.toString());
  //   return dateFormated;
  // }

  String formatDateTime(String inputDateTime) {
    DateTime dateTime = DateTime.parse(inputDateTime);
    String formattedDateTime = DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
    return formattedDateTime;
  }

  // ============= Accept and Reject invitation =============//
  onTapAcceptInvitation(Occasion occasion) async {
    respondToInvitation(occasion, 'accept');
  }

  onTapRejectInvitation(Occasion occasion) async {
    Get.defaultDialog(
        title: "رفض",
        content: Column(
          children: [
            Text(
              "هل تريد رفض دعوة ${occasion.occasionUsername}؟ ",
              style: titleMedium,
            ),
            const SizedBox(height: 15),
            CustomTextField(
                textEditingController: excuse, hintText: 'ارسال عذر (اختياري)'),
          ],
        ),
        onConfirm: () {
          Get.back();
          respondToInvitation(occasion, 'reject', excuse.text);
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  respondToInvitation(Occasion occasion, String respond,
      [String excuse = '', String message = '']) async {
    CustomDialogs.loading();

    await Future.delayed(const Duration(seconds: lateDuration));
    var response;
    if (respond == 'accept') {
      response = await occasionData.responedToInvitation(
          userId: myServices.sharedPreferences.getString("id")!,
          occasionId: occasion.occasionId.toString(),
          respond: '1',
          excuse: '');
    } else {
      response = await occasionData.responedToInvitation(
          userId: myServices.sharedPreferences.getString("id")!,
          occasionId: occasion.occasionId.toString(),
          respond: '2',
          excuse: excuse);
    }
    EasyLoading.dismiss();
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        if (message != '') {
          CustomDialogs.success(message);
        } else {
          if (respond == 'accept') {
            CustomDialogs.success('تم قبول الدعوة');
          } else {
            CustomDialogs.success('تم رفض الدعوة');
          }
        }

        occasionsToDisplay.remove(occasion);
        update();
      } else {
        CustomDialogs.failure();
      }
    } else {
      CustomDialogs.failure();
    }
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
    resetAcceptedAndSuspendedList();
  }

  resetAcceptedAndSuspendedList() {
    acceptedOccasions.clear();
    suspendedOccasions.clear();

    List<Occasion> occasionInFuture =
        filterAndOrderOccasionInFuture(myOccasions);

    for (var element in occasionInFuture) {
      if (element.acceptstatus == 1) {
        acceptedOccasions.add(element);
      } else if (element.acceptstatus == 0) {
        suspendedOccasions.add(element);
      }
    }
    needApprove = false;
    occasionsToDisplay = List.from(acceptedOccasions);
    update();
  }

  List<Occasion> filterAndOrderOccasionInFuture(List<Occasion> myOccasions) {
    final now = DateTime.now();
    List<Occasion> futureOccasions = [];

    for (var occasion in myOccasions) {
      DateTime occasionDateTime =
          DateTime.parse('${occasion.occasionDate} ${occasion.occasionTime}');
      if (occasionDateTime.isAfter(now)) {
        futureOccasions.add(occasion);
      }
    }

    futureOccasions.sort((a, b) {
      DateTime aDateTime =
          DateTime.parse('${a.occasionDate} ${a.occasionTime}');
      DateTime bDateTime =
          DateTime.parse('${b.occasionDate} ${b.occasionTime}');
      return aDateTime.compareTo(bDateTime); // Sort sooner first
    });

    return futureOccasions;
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
    inactiveNeedAprrove();

    super.onInit();
  }
}
