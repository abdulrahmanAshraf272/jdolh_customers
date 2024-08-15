import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/verifycode_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/arrow_back_button.dart';

class VerifycodeScreen extends StatelessWidget {
  const VerifycodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifycodeController());
    return WillPopScope(
      onWillPop: () async {
        // Show a confirmation dialog
        bool shouldExit = await Get.dialog<bool>(
              AlertDialog(
                title: Text('رجوع'),
                content: Text('هل تريد الرجوع الى صفحة تسجيل حساب'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: Text('لا'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller.resetPasswordOperation == 0) {
                        controller.deleteAcount();
                      }
                      Get.back(result: true);
                    },
                    child: Text('نعم'),
                  ),
                ],
              ),
            ) ??
            false; // If the user dismisses the dialog, treat it as 'No'
        return shouldExit;
      },
      child: Scaffold(
        body: GetBuilder<VerifycodeController>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: SafeArea(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              controller.exitVerifycode();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.2)),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Text('رمز التحقق'.tr,
                                  textAlign: TextAlign.center,
                                  style: headline2),
                              const SizedBox(height: 10),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                    'من فضلك ادخل الرمز المكون من 6 خانات الذي تم ارسلة عبر بريدك الالكتروني\n${controller.email}'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              const SizedBox(height: 40),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: OtpTextField(
                                  numberOfFields: 6,
                                  showFieldAsBox: true,
                                  autoFocus: true,
                                  onCodeChanged: (String code) {},
                                  onSubmit: (String verificationCode) {
                                    controller.verifycode = verificationCode;
                                    controller.checkVerifyIsCorrect();
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => Text(
                                  textAlign: TextAlign.center,
                                  '${'الوقت المتبقي لاعادة الارسال'.tr} : ${controller.remainingSeconds.value} ${'ثانية'.tr}',
                                  style: const TextStyle(
                                      fontSize: 14, color: AppColors.redText),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                  onPressed: () {
                                    controller.resendVerifycode();
                                  },
                                  child: Text('اعادة ارسال الكود؟'.tr,
                                      style: TextStyle(
                                          color: controller
                                                  .resendVerifycodeButtonActive
                                              ? AppColors.secondaryColor
                                              : Colors.grey,
                                          fontSize: 16)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
