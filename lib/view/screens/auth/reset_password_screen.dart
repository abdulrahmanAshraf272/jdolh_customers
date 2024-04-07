import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/reset_password_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/valid_input.dart';
import 'package:jdolh_customers/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ResetPasswordController>(
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
                          Text('من فضلك اكتب كلمة السر الجديدة',
                              textAlign: TextAlign.center, style: headline2),
                          SizedBox(height: Get.height * 0.06),

                          CustomTextFormAuthTwo(
                            obscureText: controller.passwordVisible,
                            visiblePasswordOnTap: () {
                              controller.showPassword();
                            },
                            labelText: 'كلمة السر',
                            valid: (val) {
                              return validInput(val!, 5, 100, 'password');
                            },
                            iconData: Icons.lock_outline,
                            textEditingController: controller.password,
                          ),
                          CustomTextFormAuthTwo(
                            obscureText: controller.passwordVisible,
                            visiblePasswordOnTap: () {
                              controller.showPassword();
                            },
                            labelText: 'اعد ادخال كلمة السر',
                            valid: (val) {
                              return validInput(val!, 5, 100, 'password');
                            },
                            iconData: Icons.lock_outline,
                            textEditingController:
                                controller.checkMatchPassword,
                          ),
                          const SizedBox(height: 20),
                          CustomButtonOne(
                              textButton: 'حفظ',
                              onPressed: () async {
                                await controller.resetPassword();
                              }),
                        ]),
                  ),
                ),
              ),
            )),
      )),
    );
  }
}
