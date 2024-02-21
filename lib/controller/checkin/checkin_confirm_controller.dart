import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/checkin.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/place.dart';

class CheckinConfirmController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  CheckinData checkinData = CheckinData(Get.find());
  TextEditingController comment = TextEditingController();
  MyServices myServices = Get.find();
  late Place placeSelected;
  List<Friend> members = [];
  List<int> membersId = [];
  ValuesController valuesController = Get.put(ValuesController());

  onTapAddMembers() {
    Get.toNamed(AppRouteName.addMembersCheckin)!.then((value) => update());
  }

  removeMember(index) {
    membersId.remove(members[index].userId!);
    members.remove(members[index]);

    update();
  }

  checkin(BuildContext context) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await checkinData.checkin(
        myServices.sharedPreferences.getString("id")!,
        placeSelected.fromGoogle ?? '0',
        placeSelected.placeId.toString(),
        placeSelected.name ?? '',
        placeSelected.type ?? '',
        placeSelected.location ?? '',
        placeSelected.lat.toString(),
        placeSelected.lng.toString(),
        comment.text);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'تم تسجيل الوصول',
          btnOkText: 'حسنا',
          onDismissCallback: (dismissType) {
            Get.offAllNamed(AppRouteName.mainScreen);
          },
        ).show();
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
  }

  @override
  void onInit() {
    placeSelected = Get.arguments;
    super.onInit();
  }
}
