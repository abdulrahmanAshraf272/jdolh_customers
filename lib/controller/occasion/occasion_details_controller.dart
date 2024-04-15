import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/person.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class OccasionDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController excuse = TextEditingController();
  OccasionsController occasionsController = Get.find();
  //ValuesController valuesController = Get.find();
  late Occasion occasionSelected;
  late int occasionId;
  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();
  List<Friend> members = [];

  String occasionLocation = '';
  String occasionLocationLink = '';

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
          await occasionsController.respondToInvitation(
              occasionSelected, 'reject', excuse.text, 'تم مغادرة المناسبة');
          await Future.delayed(const Duration(seconds: 1));
          Get.back();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  onTapAcceptInvitation() async {
    await occasionsController.respondToInvitation(occasionSelected, 'accept');
    await Future.delayed(const Duration(seconds: 1));
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
          await occasionsController.respondToInvitation(
              occasionSelected, 'reject', excuse.text);
          await Future.delayed(const Duration(seconds: 1));
          Get.back();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  @override
  void onInit() {
    occasionSelected = Get.arguments;
    occasionLocation = occasionSelected.occasionLocation ?? 'لم يتم تحديد موقع';
    occasionLocationLink = occasionSelected.locationLink ?? 'لم يتم تحديد رابط';
    getOccasionMembers(occasionSelected.occasionId.toString());
    super.onInit();
  }
}
