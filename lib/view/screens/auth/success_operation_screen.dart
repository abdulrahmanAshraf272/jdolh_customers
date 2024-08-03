import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class SuccessOperation extends StatefulWidget {
  const SuccessOperation({super.key});

  @override
  State<SuccessOperation> createState() => _SuccessOperationState();
}

class _SuccessOperationState extends State<SuccessOperation> {
  bool resetPassword = false;
  @override
  void initState() {
    if (Get.arguments != null) {
      resetPassword = Get.arguments['resetPassword'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
                child: Icon(Icons.check_circle_outline,
                    size: 150.w, color: AppColors.secondaryColor)),
            Text('تهانيا!'.tr, style: headline4),
            const SizedBox(height: 15),
            Text(
                resetPassword
                    ? 'تم تغيير كلمة السر بنجاح'.tr
                    : 'تمت انشاء الحساب بنجاح'.tr,
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.5))),
            const Spacer(),
            CustomButtonOne(
                textButton: 'ابدأ'.tr,
                onPressed: () {
                  if (resetPassword) {
                    Get.offAllNamed(AppRouteName.login);
                  } else {
                    Get.offAllNamed(AppRouteName.mainScreen);
                  }
                })
          ],
        ),
      ),
    );
  }
}
