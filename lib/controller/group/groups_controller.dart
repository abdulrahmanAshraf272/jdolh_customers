import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/groups.dart';
import 'package:jdolh_customers/data/models/group.dart';

class GroupsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  GroupsData groupsData = GroupsData(Get.find());
  MyServices myServices = Get.find();
  List<Group> groups = [];

  getAllGroups() async {
    statusRequest = StatusRequest.loading;
    update();
    groups.clear();
    var response = await groupsData.groupsView(
        userId: myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseGroups = response['data'];
        //parsing jsonList to DartList.
        groups = responseGroups.map((e) => Group.fromJson(e)).toList();

        //conver data from timeStamp to data only
        for (int i = 0; i < groups.length; i++) {
          groups[i].groupDatecreated = convertDate(groups[i].groupDatecreated!);
        }
        // groups
        //     .map((e) => e.groupDatecreated = convertDate(e.groupDatecreated!));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  onTapGroupCard(int index) {
    if (groups[index].creator == 1) {
      Get.toNamed(AppRouteName.editGroup, arguments: groups[index])!
          .then((value) => update());
    } else {
      Get.toNamed(AppRouteName.groupDetails, arguments: groups[index])!
          .then((value) => update());
    }
  }

  onTapCreateGroup() {
    Get.toNamed(AppRouteName.createGroup)!.then((value) => update());
  }

  String convertDate(String dateString) {
    // Parse the date string using DateTime.parse()
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date without time using DateFormat.yMd()
    String formattedDate = DateFormat.yMd().format(dateTime);

    return formattedDate;
  }

  @override
  void onInit() {
    getAllGroups();

    super.onInit();
  }
}
