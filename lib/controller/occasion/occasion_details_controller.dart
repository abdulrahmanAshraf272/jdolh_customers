import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/person.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class OccasionDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController excuse = TextEditingController();
  ValuesController valuesController = Get.find();
  late Occasion occasionSelected;
  late int occasionId;
  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();
  List<Friend> members = [];

  getOccasionMembers(String occasionId) async {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    statusRequest = StatusRequest.loading;
    update();
    members.clear();
    var response = await occasionData.viewInvitors(occasionId);
    statusRequest = handlingData(response);

    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseOccasionMembers = response['data'];
        //parsing jsonList to DartList.
        members =
            responseOccasionMembers.map((e) => Friend.fromJson(e)).toList();
        //remove me form list
        members.removeWhere((element) => element.userId == myId);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  onTapPersonCard(index) {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    if (members[index].userId != myId) {
      // final person = Person(
      //     userId: members[index].userId,
      //     userName: members[index].userName,
      //     userUsername: members[index].userUsername,
      //     userImage: members[index].userImage);
      Get.toNamed(AppRouteName.personProfile, arguments: members[index]);
    }
  }

  String displayMemberStatus(int index) {
    if (members[index].creator == 1) {
      return textCreator;
    } else if (members[index].invitorStatus == 0) {
      return textSuspendAttend;
    } else if (members[index].invitorStatus == 1) {
      return textConfirmAttend;
    } else {
      return textRejectAttend;
    }
  }

  Color displayMemberStatusColor(int index) {
    if (members[index].creator == 1) {
      return AppColors.secondaryColor;
    } else if (members[index].invitorStatus == 0) {
      return Colors.grey;
    } else if (members[index].invitorStatus == 1) {
      return Colors.green;
    } else {
      return AppColors.redText;
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
            SizedBox(height: 15),
            CustomTextField(
                textEditingController: excuse, hintText: 'ارسال عذر (اختياري)'),
          ],
        ),
        middleText: "هل تريد مغادرة المناسبة؟",
        onConfirm: () {
          leaveOccasion();
          valuesController.changeInvitorStatus(occasionSelected.occasionId!, 2);
          Get.back();
          Get.back();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  leaveOccasion() async {
    var response = await occasionData.rejectInvitation(
        occasionSelected.occasionId.toString(),
        myServices.sharedPreferences.getString("id")!,
        excuse.text,
        occasionSelected.occasionUserid.toString());
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('leave group done');
      } else {
        print('leave group failed');
      }
    }
  }

  onTapAcceptInvitation() async {
    var resultSucceed = await acceptInvitation();
    if (resultSucceed) {
      Get.rawSnackbar(
          message: 'تم قبول دعوة ${occasionSelected.occasionUsername}');
      valuesController.changeInvitorStatus(occasionSelected.occasionId!, 1);
      Get.back();
    }
  }

  Future<bool> acceptInvitation() async {
    var response = await occasionData.acceptInvitation(
        myServices.sharedPreferences.getString("id")!,
        occasionSelected.occasionId.toString());
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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
            SizedBox(height: 15),
            CustomTextField(
                textEditingController: excuse, hintText: 'ارسال عذر (اختياري)'),
          ],
        ),
        onConfirm: () async {
          var resultSucceed = await rejectInvitation();
          if (resultSucceed) {
            Get.back();
            Get.rawSnackbar(
                message: 'تم رفض دعوة ${occasionSelected.occasionUsername}');
            valuesController.changeInvitorStatus(
                occasionSelected.occasionId!, 2);
            Get.back();
          }
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  Future<bool> rejectInvitation() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await occasionData.rejectInvitation(
        myServices.sharedPreferences.getString("id")!,
        occasionSelected.occasionId.toString(),
        excuse.text,
        occasionSelected.occasionUserid.toString());
    statusRequest = handlingData(response);
    update();
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    occasionSelected = Get.arguments;
    getOccasionMembers(occasionSelected.occasionId.toString());
    super.onInit();
  }
}
