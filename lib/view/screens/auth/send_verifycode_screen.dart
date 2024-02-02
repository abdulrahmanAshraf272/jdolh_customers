import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/send_verifycode_controller.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/valid_input.dart';
import 'package:jdolh_customers/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class SendVerifycodeScreen extends StatelessWidget {
  const SendVerifycodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SendVerifycodeController());
    return Scaffold(
      body: Center(
        child: Form(
          key: controller.formstate,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(height: Get.height * 0.1),
                  Text('Enter Your Phone Number', style: headline2),
                  SizedBox(height: Get.height * 0.06),

                  CustomTextFormAuth(
                    hintText: '05234******',
                    labelText: 'Phone',
                    valid: (val) {
                      return validInput(val!, 10, 10, 'phone');
                    },
                    iconData: Icons.phone_android_outlined,
                    textEditingController: controller.phoneNumber,
                  ),

                  const SizedBox(height: 20),
                  CustomButtonOne(
                      textButton: 'Next',
                      onPressed: () async {
                        await controller.sendVerifycode();
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
