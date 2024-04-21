import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/forget_password_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    return Scaffold(
      body: Center(
          child: GetBuilder<ForgetPasswordController>(
              builder: (controller) => HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //SizedBox(height: Get.height * 0.1),
                            Text(
                              'سيتم ارسال رمز التحقق الى بريدك الالكتروني',
                              style: headline2,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: Get.height * 0.06),

                            const SizedBox(height: 20),
                            CustomButtonOne(
                                textButton: 'التالي',
                                onPressed: () async {
                                  await controller.sendVerifycode();
                                }),
                          ]),
                    ),
                  ))),
    );
  }
}
