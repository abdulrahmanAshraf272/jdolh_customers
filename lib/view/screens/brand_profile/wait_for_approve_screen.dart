import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/wait_for_approve_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:lottie/lottie.dart';

class WaitForApproveScreen extends StatelessWidget {
  const WaitForApproveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WaitForApproveController());
    return Scaffold(
      body: GetBuilder<WaitForApproveController>(
        builder: (controller) => Center(
            child: controller.approveStatus == ApproveStatus.waiting
                ? const Waiting()
                : controller.approveStatus == ApproveStatus.approved
                    ? const ResApproved()
                    : const ResRejected()),
      ),
    );
  }
}

class ResRejected extends StatelessWidget {
  const ResRejected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WaitForApproveController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('تم رفض طلبك'),
        const SizedBox(height: 20),
        Text(controller.rejectionReason),
        const SizedBox(height: 40),
        GoHomeButton(
            text: 'الرئيسية',
            onTap: () {
              Get.toNamed(AppRouteName.mainScreen);
            })
      ],
    );
  }
}

class ResApproved extends StatelessWidget {
  const ResApproved({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WaitForApproveController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Icon(Icons.check_circle_outline,
                size: 150.w, color: AppColors.secondaryColor)),
        const SizedBox(height: 20),
        const Text('تم قبول طلبك!'),
        const SizedBox(height: 40),
        GoHomeButton(
            text: 'التالي',
            onTap: () {
              controller.gotoPayment();
            })
      ],
    );
  }
}

class Waiting extends StatelessWidget {
  const Waiting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(WaitForApproveController());
    return GetBuilder<WaitForApproveController>(
        builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'برجاء الانتظار حتى تتم مراجعة بيانات الحجز',
                  style: titleMedium,
                ),
                const SizedBox(height: 20),
                Lottie.asset('assets/icons/loading2.json',
                    width: Get.width * 0.5),
                const SizedBox(height: 50),
                TextButton(
                    onPressed: () {
                      controller.getRes();
                    },
                    child: const Text('تحديث الصفحة')),
                const SizedBox(height: 20),
                if (controller.statusRequest == StatusRequest.loading)
                  const CircularProgressIndicator()
              ],
            ));
  }
}
