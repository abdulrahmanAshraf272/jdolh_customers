import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/occasion_notification.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class OccasionDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusOccasion = StatusRequest.none;
  StatusRequest statusRequestMembers = StatusRequest.none;
  TextEditingController excuse = TextEditingController();
  late Occasion occasionSelected;
  late int occasionId;
  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();
  List<Friend> members = [];

  String occasionLocation = '';
  String occasionLocationLink = '';
  String selectedTimeFormatted = '';

  bool inPast = false;

  getOccasionMembers(String occasionId) async {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    statusRequestMembers = StatusRequest.loading;
    update();
    members.clear();
    var response = await occasionData.viewInvitors(occasionId);
    statusRequestMembers = handlingData(response);

    print('status ==== $statusRequestMembers');
    if (statusRequestMembers == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseOccasionMembers = response['data'];
        //parsing jsonList to DartList.
        members =
            responseOccasionMembers.map((e) => Friend.fromJson(e)).toList();
        //remove me form list
        members.removeWhere((element) => element.userId == myId);
      } else {
        statusRequestMembers = StatusRequest.failure;
      }
    }
    update();
  }

  onTapPersonCard(index) {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    if (members[index].userId != myId) {
      Get.toNamed(AppRouteName.personProfile, arguments: members[index]);
    }
  }

  String displayMemberStatus(int index) {
    if (members[index].creator == 1) {
      return textCreator;
    } else if (members[index].invitorStatus == 2) {
      return textRejectAttend;
    } else if (members[index].invitorStatus == 1) {
      return textConfirmAttend;
    } else {
      return textSuspendAttend;
    }
  }

  Color displayMemberStatusColor(int index) {
    if (members[index].creator == 1) {
      return AppColors.secondaryColor;
    } else if (members[index].invitorStatus == 2) {
      return AppColors.redText;
    } else if (members[index].invitorStatus == 1) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  onTapLeaveOccasion() {
    Get.defaultDialog(
        title: "مغادرة",
        content: Column(
          children: [
            Text(
              "هل تريد مغادرة المناسبة؟",
              style: titleMedium,
            ),
            const SizedBox(height: 15),
            CustomTextField(
                textEditingController: excuse, hintText: 'ارسال عذر (اختياري)'),
          ],
        ),
        middleText: "هل تريد مغادرة المناسبة؟",
        onConfirm: () async {
          Get.back();
          await respondToInvitation(
              occasionSelected, '2', excuse.text, 'تم مغادرة المناسبة');

          //Send notification to creator
          OccasionNotification.rejectOccasion(
              occasionSelected.occasionUserid!,
              myServices.getName(),
              myServices.getImage(),
              occasionSelected.occasionTitle ?? '',
              excuse.text);
          Get.back();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  onTapAcceptInvitation() async {
    await respondToInvitation(occasionSelected, '1');

    OccasionNotification.acceptOccasion(
        occasionSelected.occasionUserid!,
        myServices.getName(),
        myServices.getImage(),
        occasionSelected.occasionTitle!);
    Get.back();
  }

  onTapRejectInvitation() async {
    Get.defaultDialog(
        title: "رفض",
        content: Column(
          children: [
            Text(
              "هل تريد رفض دعوة ${occasionSelected.occasionUsername}؟ ",
              style: titleMedium,
            ),
            const SizedBox(height: 15),
            CustomTextField(
                textEditingController: excuse, hintText: 'ارسال عذر (اختياري)'),
          ],
        ),
        onConfirm: () async {
          Get.back();
          await respondToInvitation(occasionSelected, '2', excuse.text);
          //Send notification to creator
          OccasionNotification.rejectOccasion(
              occasionSelected.occasionUserid!,
              myServices.getName(),
              myServices.getImage(),
              occasionSelected.occasionTitle ?? '',
              excuse.text);
          Get.back();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  respondToInvitation(Occasion occasion, String respond,
      [String excuse = '', String message = '']) async {
    CustomDialogs.loading();

    var response = await occasionData.responedToInvitation(
        userId: myServices.sharedPreferences.getString("id")!,
        occasionId: occasion.occasionId.toString(),
        respond: respond,
        excuse: excuse);
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
      } else {
        CustomDialogs.failure();
      }
    } else {
      CustomDialogs.failure();
    }
  }

  String timeInAmPm() {
    if (selectedTimeFormatted != '') {
      final parts = selectedTimeFormatted.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final dateTime = DateTime(0, 0, 0, hour, minute);
      final formatter = DateFormat('h:mm a');
      return formatter.format(dateTime);
    } else {
      return 'لم يتم تحديد وقت المناسبة';
    }
  }

  bool checkInPast(String dateString, String timeString) {
    DateTime dateTime =
        DateFormat("yyyy-MM-dd HH:mm").parse("$dateString $timeString");
    DateTime currentDateTime = DateTime.now();

    return dateTime.isBefore(currentDateTime);
  }

  getOccasion(int occasionId) async {
    statusOccasion = StatusRequest.loading;
    update();
    var response = await occasionData.getOccasion(
        occasionId: occasionId.toString(), userid: myServices.getUserid());
    statusOccasion = handlingData(response);
    if (statusOccasion == StatusRequest.success) {
      if (response['status'] == 'success') {
        occasionSelected = Occasion.fromJson(response['data']);
      } else {
        statusOccasion = StatusRequest.failure;
      }
    }
    update();
  }

  receiveData() async {
    var argument = Get.arguments;
    if (argument is Occasion) {
      occasionSelected = argument;
    } else if (argument is int) {
      await getOccasion(argument);
    } else {
      statusOccasion = StatusRequest.failure;
      update();
      return;
    }

    occasionLocation = occasionSelected.occasionLocation ?? 'لم يتم تحديد موقع';
    occasionLocationLink = occasionSelected.locationLink ?? 'لم يتم تحديد رابط';
    selectedTimeFormatted = occasionSelected.occasionTime ?? '';
    getOccasionMembers(occasionSelected.occasionId.toString());

    inPast = checkInPast(
        occasionSelected.occasionDate!, occasionSelected.occasionTime!);
  }

  @override
  void onInit() {
    receiveData();
    super.onInit();
  }
}
