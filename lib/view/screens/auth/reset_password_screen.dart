import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/reset_password_controller.dart';
import 'package:jdolh_customers/controller/auth/signup_controller.dart';
import 'package:jdolh_customers/core/functions/valid_input.dart';
import 'package:jdolh_customers/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_customers/view/widgets/auth/have_account_question.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ResetPasswordController>(
        builder: (controller) => Form(
          key: controller.formstate,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //SizedBox(height: Get.height * 0.1),
                      Text('Enter New Password',
                          style: Theme.of(context).textTheme.displayLarge),
                      SizedBox(height: Get.height * 0.06),

                      CustomTextFormAuth(
                        obscureText: controller.passwordVisible,
                        visiblePasswordOnTap: () {
                          controller.showPassword();
                        },
                        hintText: 'Enter Your Password',
                        labelText: 'Password',
                        valid: (val) {
                          return validInput(val!, 5, 100, 'password');
                        },
                        iconData: Icons.lock_outline,
                        textEditingController: controller.password,
                      ),
                      CustomTextFormAuth(
                        obscureText: controller.passwordVisible,
                        visiblePasswordOnTap: () {
                          controller.showPassword();
                        },
                        hintText: 'Rewrite New Password',
                        labelText: 'Password Again',
                        valid: (val) {
                          return validInput(val!, 5, 100, 'password');
                        },
                        iconData: Icons.lock_outline,
                        textEditingController: controller.checkMatchPassword,
                      ),
                      CustomButtonOne(
                          textButton: 'Save',
                          onPressed: () async {
                            await controller.resetPassword();
                          }),
                    ]),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
