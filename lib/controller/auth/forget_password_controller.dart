import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/auth/forget_password.dart';

class ForgetPasswordController extends GetxController {
  late String email;
  ForgetPasswordData forgetPasswordData = ForgetPasswordData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  sendVerifycode() async {
    CustomDialogs.loading();

    var response = await forgetPasswordData.postData(email);
    statusRequest = handlingData(response);
    CustomDialogs.dissmissLoading();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        goToVerifycode();
      } else {
        Get.rawSnackbar(
            message:
                'حدث خطأ,ارجع وتأكد من كتابتك لاسم المستخدم او الايميل بشكل صحيح');
      }
    } //else => will be hendled by HandlingDataView.
  }

  goToVerifycode() {
    Get.offNamed(AppRouteName.verifyCode,
        arguments: {"email": email, 'resetPassword': 1});
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }
}
