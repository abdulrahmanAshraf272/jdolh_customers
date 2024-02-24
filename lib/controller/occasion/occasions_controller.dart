import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class OccasionsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController excuse = TextEditingController();

  ValuesController valuesController = Get.find();
  List<Occasion> occasionsToDisplay = [];

  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();

  bool needApprove = false;
  activeNeedApprove() {
    needApprove = true;
    occasionsToDisplay = List.from(valuesController.suspendedOccasions);
    update();
  }

  inactiveNeedAprrove() {
    needApprove = false;
    occasionsToDisplay = List.from(valuesController.acceptedOccasions);
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
          .then((value) => update());
    } else {
      Get.toNamed(AppRouteName.occasionDetails,
              arguments: occasionsToDisplay[index])!
          .then((value) => update());
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

  onTapAcceptInvitation(int index) async {
    var resultSucceed = await acceptInvitation(index);
    if (resultSucceed) {
      Get.rawSnackbar(
          message:
              'تم قبول دعوة ${occasionsToDisplay[index].occasionUsername}');
      valuesController.changeInvitorStatus(
          occasionsToDisplay[index].occasionId!, 1);
      activeNeedApprove();
    }
  }

  Future<bool> acceptInvitation(int index) async {
    var response = await occasionData.acceptInvitation(
        myServices.sharedPreferences.getString("id")!,
        occasionsToDisplay[index].occasionId.toString());
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

  onTapDisplayLocation(int index) {
    String occasionLocation = occasionsToDisplay[index].occasionLocation ?? '';
    String occasionLocationLink = occasionsToDisplay[index].locationLink ?? '';
    if (occasionLocation != '' && occasionLocationLink != '') {
      //TODO: open bottm sheet to make user to choose if open location or location link
      Get.bottomSheet(Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: AppColors.gray,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اختر طريقة عرض الموقع',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 20),
            GoHomeButton(
                onTap: () {
                  openUrlLink(occasionLocationLink);
                },
                text: 'تطبيق Googel Maps',
                width: Get.width - 40,
                height: 38.h),
            const SizedBox(height: 10),
            GoHomeButton(
                onTap: () {
                  goToDisplayLocation(index);
                },
                text: 'روية الموقع هنا',
                width: Get.width - 40,
                height: 38.h),
          ],
        ),
      ));
    } else if (occasionLocation != '') {
      goToDisplayLocation(index);
    } else if (occasionLocationLink != '') {
      //the occasion only have location link
      openUrlLink(occasionLocationLink);
    } else {
      //the occasion doesn't have location nor location link
      Get.rawSnackbar(message: 'لم يتم تحديد مكان المناسبة');
    }
  }

  goToDisplayLocation(int index) {
    double lat = double.parse(occasionsToDisplay[index].occasionLat!);
    double lng = double.parse(occasionsToDisplay[index].occasionLong!);
    Get.toNamed(AppRouteName.diplayLocation, arguments: LatLng(lat, lng));
  }

  onTapRejectInvitation(int index) async {
    Get.defaultDialog(
        title: "رفض",
        content: Column(
          children: [
            Text(
              "هل تريد رفض دعوة ${occasionsToDisplay[index].occasionUsername}؟ ",
              style: titleMedium,
            ),
            SizedBox(height: 15),
            CustomTextField(
                textEditingController: excuse, hintText: 'ارسال عذر (اختياري)'),
          ],
        ),
        onConfirm: () async {
          var resultSucceed = await rejectInvitation(index);
          if (resultSucceed) {
            Get.back();
            Get.rawSnackbar(
                message:
                    'تم رفض دعوة ${occasionsToDisplay[index].occasionUsername}');
            valuesController.changeInvitorStatus(
                occasionsToDisplay[index].occasionId!, 2);
            activeNeedApprove();
          }
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  Future<bool> rejectInvitation(int index) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await occasionData.rejectInvitation(
        myServices.sharedPreferences.getString("id")!,
        occasionsToDisplay[index].occasionId.toString(),
        excuse.text,
        occasionsToDisplay[index].occasionUserid.toString());
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
    //getOccasionFromMainController();
    inactiveNeedAprrove();

    super.onInit();
  }
}
