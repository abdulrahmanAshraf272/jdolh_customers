import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/signup_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/alert_exit_app.dart';
import 'package:jdolh_customers/core/functions/valid_input.dart';
import 'package:jdolh_customers/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_customers/view/widgets/auth/have_account_question.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      body: SafeArea(
          child: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<SignUpController>(
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
                                Text('JDOLH',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 33.sp,
                                      color: AppColors.primaryColor,
                                    )),
                                SizedBox(height: 20),
                                Text('إنشاء حساب جديد', style: headline2),
                                SizedBox(height: 20),
                                CustomTextFormAuthTwo(
                                  hintText: 'اسمك',
                                  labelText: 'Name',
                                  valid: (val) => validInput(val!, 2, 100),
                                  iconData: Icons.person,
                                  textEditingController: controller.name,
                                ),
                                CustomTextFormAuthTwo(
                                  hintText: 'اسم المستخدم',
                                  labelText: 'Username',
                                  valid: (val) =>
                                      validInput(val!, 2, 50, 'username'),
                                  iconData: Icons.person,
                                  textEditingController: controller.username,
                                ),

                                CustomTextFormAuthTwo(
                                  hintText: 'البريد الإلكتروني',
                                  labelText: 'Email',
                                  valid: (val) {
                                    return validInput(val!, 5, 100, 'email');
                                  },
                                  iconData: Icons.email_outlined,
                                  textEditingController: controller.email,
                                ),

                                CustomTextFormAuthTwo(
                                  obscureText: controller.passwordVisible,
                                  visiblePasswordOnTap: () {
                                    controller.showPassword();
                                  },
                                  hintText: 'الرقم السري',
                                  labelText: 'Password',
                                  valid: (val) {
                                    return validInput(val!, 5, 100, 'password');
                                  },
                                  iconData: Icons.lock_outline,
                                  textEditingController: controller.password,
                                ),

                                CustomTextFormAuthTwo(
                                  hintText: 'رقم الجوال',
                                  labelText: 'Phone',
                                  valid: (val) {
                                    return validInput(val!, 10, 10, 'phone');
                                  },
                                  iconData: Icons.phone_android_outlined,
                                  textEditingController: controller.phoneNumber,
                                ),
                                const SizedBox(height: 20),
                                CustomButtonOne(
                                    textButton: 'إنشاء حساب',
                                    onPressed: () async {
                                      await controller.signUp();
                                    }),
                                HaveAccountQuestion(
                                    onPress: () => controller.goToLogin(),
                                    text: "لديك حساب بالفعل؟",
                                    buttonText: 'تسجيل دخول')
                              ]),
                        ),
                      ),
                    ),
                  ),
                )),
      )),
    );
  }
}
