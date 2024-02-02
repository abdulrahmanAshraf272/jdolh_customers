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
      appBar: AppBar(
          centerTitle: true,
          //backgroundColor: AppColor.primaryColor,
          elevation: 0,
          title: Text(
            'Verification Code',
          )),
      body: GetBuilder<VerifycodeController>(
          builder: (controller) => HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Container(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      Text('Check Your Phone',
                          textAlign: TextAlign.center, style: headline2),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text('Please Enter The OTP Code.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                      SizedBox(height: Get.height * 0.1),
                      OtpTextField(
                        numberOfFields: 6,
                        //borderColor: Colors.black,
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {
                          controller.verifycode = verificationCode;
                          controller.checkVerifyIsCorrect();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => Text(
                          textAlign: TextAlign.center,
                          'Time remaining: ${controller.remainingSeconds.value} seconds',
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.gray),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: () {
                            controller.resendVerifycode();
                          },
                          child: const Text('Resend Code',
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 18)))
                    ],
                  ),
                ),
              )),
    );
  }
}
