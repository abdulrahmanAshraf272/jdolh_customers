import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/is_date_passed.dart';
import 'package:jdolh_customers/core/notification/notification_sender/occasion_notification.dart';
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
  List<Occasion> myOccasions = [];
  List<Occasion> acceptedOccasions = [];
  List<Occasion> suspendedOccasions = [];

  int needApproveOccasionsNo = 0;
  bool needApprove = false;

  onTapOccasionCard(int index) async {
    final result;
    if (occasionsToDisplay[index].creator == 1) {
      result = await Get.toNamed(AppRouteName.editOccasion,
          arguments: occasionsToDisplay[index]);
    } else {
      result = await Get.toNamed(AppRouteName.occasionDetails,
          arguments: occasionsToDisplay[index]);
    }

    if (result != null) {
      getMyOccasion();
    }
  }

  changeNeedApproveValue(bool displayNeedApprove) {
    needApprove = displayNeedApprove;

    resetAcceptedAndSuspendedList();
  }

  onTapCreate() async {
    final result = await Get.toNamed(AppRouteName.createOccasion);
    if (result != null) {
      getMyOccasion();
    }
  }

  String formatDateTime(String inputDateTime) {
    DateTime dateTime = DateTime.parse(inputDateTime);
    String formattedDateTime = DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
    return formattedDateTime;
  }

  // ============= Accept and Reject invitation =============//
  onTapAcceptInvitation(Occasion occasion) async {
    respondToInvitation(occasion, 'accept');

    OccasionNotification.acceptOccasion(occasion.occasionUserid!,
        myServices.getName(), myServices.getImage(), occasion.occasionTitle!);
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

          OccasionNotification.rejectOccasion(
              occasion.occasionUserid!,
              myServices.getName(),
              myServices.getImage(),
              occasion.occasionTitle ?? '',
              excuse.text);
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

        getMyOccasion();
      } else {
        CustomDialogs.failure();
      }
    } else {
      CustomDialogs.failure();
    }
  }

  getMyOccasion() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await occasionData
        .viewOccasions(myServices.sharedPreferences.getString("id")!);
    await Future.delayed(const Duration(seconds: lateDuration));
    statusRequest = handlingData(response);
    update();
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parsingDataFromJsonToDartList(response);
      }
    }
  }

  parsingDataFromJsonToDartList(response) {
    myOccasions.clear();

    List responseOccasoins = response['data'];
    myOccasions = responseOccasoins.map((e) => Occasion.fromJson(e)).toList();

    //Remove occasions in the past
    myOccasions.removeWhere((element) => isDatePassed(element.occasionDate!));

    resetAcceptedAndSuspendedList();
  }

  resetAcceptedAndSuspendedList() {
    occasionsToDisplay.clear();
    acceptedOccasions.clear();
    suspendedOccasions.clear();

    for (var element in myOccasions) {
      if (element.acceptstatus == 1) {
        acceptedOccasions.add(element);
      } else if (element.acceptstatus == 0) {
        suspendedOccasions.add(element);
      }
    }
    needApproveOccasionsNo = suspendedOccasions.length;
    // needApprove = false;
    // occasionsToDisplay = List.from(acceptedOccasions);
    // update();
    if (needApprove) {
      occasionsToDisplay = List.from(suspendedOccasions);
    } else {
      occasionsToDisplay = List.from(acceptedOccasions);
    }
    update();
  }

  @override
  void onInit() async {
    getMyOccasion();
    super.onInit();
  }
}
