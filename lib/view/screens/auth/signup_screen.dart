import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/signup_controller.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/valid_input.dart';
import 'package:jdolh_customers/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_customers/view/widgets/auth/have_account_question.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<SignUpController>(
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
                      Text('إنشاء حساب جديد', style: headline2),
                      SizedBox(height: Get.height * 0.06),
                      CustomTextFormAuth(
                        hintText: 'Ahmed Ali',
                        labelText: 'Name',
                        valid: (val) => validInput(val!, 3, 100),
                        iconData: Icons.person,
                        textEditingController: controller.username,
                      ),
                      CustomTextFormAuth(
                        hintText: 'ahmad_Ali99',
                        labelText: 'Username',
                        valid: (val) => validInput(val!, 5, 50, 'username'),
                        iconData: Icons.person,
                        textEditingController: controller.userID,
                      ),

                      CustomTextFormAuth(
                        hintText: '05234******',
                        labelText: 'Phone',
                        valid: (val) {
                          return validInput(val!, 10, 10, 'phone');
                        },
                        iconData: Icons.phone_android_outlined,
                        textEditingController: controller.phoneNumber,
                      ),
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
                      CustomButtonOne(
                          textButton: 'SignUp',
                          onPressed: () async {
                            await controller.signUp();
                          }),
                      const SizedBox(height: 20),
                      HaveAccountQuestion(
                          onPress: () => controller.goToLogin(),
                          text: "have an account?",
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
