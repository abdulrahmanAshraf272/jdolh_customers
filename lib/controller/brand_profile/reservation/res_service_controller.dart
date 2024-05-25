import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_parent_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';

class ResServiceConltroller extends ResParentController {
  onTapConfirmRes() async {
    if (cartController.carts.isEmpty) {
      Get.rawSnackbar(message: 'السلة فارغة!');
      return;
    }
    if (selectedDate == '') {
      Get.rawSnackbar(message: 'من فضلك اختر وقت الحجز');
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var result = await createRes();
    update();
    if (result != null) {
      //clear cart beacause it's not null any more , it take the resid = id of res just created.
      //brandProfileController.carts.clear();
      if (resDetails.reviewRes == 0) {
        Get.offNamed(AppRouteName.payment, arguments: result);
      } else {
        Get.offNamed(AppRouteName.waitForApprove, arguments: result);
      }
    }
  }
}
