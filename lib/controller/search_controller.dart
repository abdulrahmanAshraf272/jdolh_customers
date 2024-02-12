import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/search_person.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';

class SearchScreenController extends GetxController {
  bool isPersonSearch = true;
  StatusRequest statusRequest = StatusRequest.none;
  SearchPersonData searchPersonData = SearchPersonData(Get.find());
  MyServices myServices = Get.find();
  TextEditingController name = TextEditingController();
  List<PersonWithFollowState> data = [];

  activePersonSearch() {
    isPersonSearch = true;
    update();
  }

  inactivePersonSearch() {
    isPersonSearch = false;
    update();
  }

  seachOnTap() {
    if (isPersonSearch) {
      getPeopleSearchedFor();
    }
  }

  getPeopleSearchedFor() async {
    statusRequest = StatusRequest.loading;
    update();
    data.clear();
    var response = await searchPersonData.postData(
        myServices.sharedPreferences.getString("id")!, name.text);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseJsonData = response['data'];
        print('$responseJsonData');
        //parsing jsonList to DartList.
        data = responseJsonData
            .map((e) => PersonWithFollowState.fromJson(e))
            .toList();
        remoreMyselfIfWriteMyName();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  remoreMyselfIfWriteMyName() {
    //Remove me if i write my
    for (int i = 0; i < data.length; i++) {
      if (data[i].userId.toString() ==
          myServices.sharedPreferences.getString("id")!) {
        data.remove(data[i]);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
  }
}
