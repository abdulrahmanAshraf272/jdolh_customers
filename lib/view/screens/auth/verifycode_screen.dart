import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/verifycode_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class VerifycodeScreen extends StatelessWidget {
  const VerifycodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifycodeController());
    return Scaffold(
      body: GetBuilder<VerifycodeController>(
          builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Container(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text('رمز التحقق'.tr,
                          textAlign: TextAlign.center, style: headline2),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                            'من فضلك ادخل الرمز المكون من 6 خانات الذي تم ارسلة عبر بريدك الالكتروني'
                                .tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge),
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
                                  color: controller.resendVerifycodeButtonActive
                                      ? AppColors.secondaryColor
                                      : Colors.grey,
                                  fontSize: 16)))
                    ],
                  ),
                ),
              )),
    );
  }
}
