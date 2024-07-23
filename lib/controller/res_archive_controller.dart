import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ResArchiveController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());
  MyServices myServices = Get.find();

  List<Reservation> allRes = [];
  List<Reservation> resToDisplay = [];

  int displayFinishedRes = 1;

  gotoReservationDetails(int index) async {
    bool finished = displayFinishedRes == 1 ? true : false;

    Get.toNamed(AppRouteName.resArchiveDetails,
        arguments: {"res": resToDisplay[index], "finished": finished});
  }

  setDisplayFinishedRes(int value) async {
    displayFinishedRes = value;
    update();

    //Get all res from db and display filtered res
    await getAllRes();
    setResToDisplay();
  }

  getAllRes() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resData.getAllMyRes(userid: myServices.getUserid());
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        parseValues(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  parseValues(response) {
    List data = response['data'];
    allRes = data.map((e) => Reservation.fromJson(e)).toList();
  }

  setResToDisplay() {
    resToDisplay.clear();
    if (displayFinishedRes == 1) {
      //get all finished reservations
      for (int i = 0; i < allRes.length; i++) {
        if (allRes[i].resStatus == 5) {
          resToDisplay.add(allRes[i]);
        }
      }
    } else {
      //get all canceled or tardy reservations.
      for (int i = 0; i < allRes.length; i++) {
        if (allRes[i].resStatus == 4 || allRes[i].resStatus == 6) {
          resToDisplay.add(allRes[i]);
        }
      }
    }
    update();
  }

  @override
  void onInit() async {
    await getAllRes();
    setResToDisplay();
    super.onInit();
  }
}
