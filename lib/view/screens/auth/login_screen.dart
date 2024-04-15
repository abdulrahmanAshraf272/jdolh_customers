import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/login_controller.dart';
import 'package:jdolh_customers/controller/auth/signup_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/alert_exit_app.dart';
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
          child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) => alertExitAppNew(),
        child: GetBuilder<LoginController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Form(
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

                            CustomTextFormAuthTwo(
                              labelText: 'اسم المستخدم او البريد الالكتروني',
                              valid: (val) {
                                return validInput(
                                  val!,
                                  3,
                                  100,
                                );
                              },
                              iconData: Icons.person,
                              textEditingController: controller.usernameOrEmail,
                            ),

                            CustomTextFormAuthTwo(
                              obscureText: controller.passwordVisible,
                              visiblePasswordOnTap: () {
                                controller.showPassword();
                              },
                              labelText: 'كلمة السر',
                              valid: (val) {
                                return validInput(val!, 3, 100, 'password');
                              },
                              iconData: Icons.lock_outline,
                              textEditingController: controller.password,
                            ),
                            ForgetPassButton(
                              onPress: () => controller.goToForgetPassword(),
                            ),
                            const SizedBox(height: 20),
                            CustomButtonOne(
                                textButton: 'تسجيل دخول',
                                onPressed: () async {
                                  await controller.login();
                                }),
                            const SizedBox(height: 20),
                            HaveAccountQuestion(
                                onPress: () => controller.goToSignUP(),
                                text: "ليس لديك حساب؟",
                                buttonText: 'انشاء حساب')
                          ]),
                    ),
                  ),
                ),
              )),
        ),
      )),
    );
  }
}
