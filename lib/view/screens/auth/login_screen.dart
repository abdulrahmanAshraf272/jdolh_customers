import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/login_controller.dart';
import 'package:jdolh_customers/controller/auth/signup_controller.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/valid_input.dart';
import 'package:jdolh_customers/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_customers/view/widgets/auth/have_account_question.dart';
import 'package:jdolh_customers/view/widgets/auth/login/forget_pass_button.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<LoginController>(
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
                      Text('تسجيل دخول', style: headline2),
                      SizedBox(height: Get.height * 0.06),

                      CustomTextFormAuth(
                        hintText: 'ahmed@gmail.com',
                        labelText: 'Email',
                        valid: (val) {
                          return validInput(val!, 5, 100, 'email');
                        },
                        iconData: Icons.email_outlined,
                        textEditingController: controller.email,
                      ),

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
                      ForgetPassButton(
                        onPress: () => controller.goToForgetPassword(),
                      ),
                      const SizedBox(height: 20),
                      CustomButtonOne(
                          textButton: 'Login',
                          onPressed: () async {
                            await controller.login();
                          }),
                      const SizedBox(height: 20),
                      HaveAccountQuestion(
                          onPress: () => controller.goToSignUP(),
                          text: "Don't have account?",
                          buttonText: 'Sign Up')
                    ]),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
