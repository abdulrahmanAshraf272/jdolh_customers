import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/wait_for_approve_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
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
        Text('تم رفض طلبك'.tr),
        const SizedBox(height: 20),
        Text(controller.rejectionReason),
        const SizedBox(height: 40),
        GoHomeButton(onTap: () {
          controller.goHomeAfterDeleteRes();
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
        Text('تم قبول طلبك!'.tr),
        const SizedBox(height: 40),
        GoHomeButton(
            text: 'التالي'.tr,
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'طلبك الان قيد المراجعة من قبل المتجر, سيتم ارسال اشعار اليك عند الموافقة على طلبك'
                        .tr,
                    textAlign: TextAlign.center,
                    style: titleMedium,
                  ),
                ),
                Lottie.asset('assets/icons/loading2.json',
                    width: Get.width * 0.5),
                const SizedBox(height: 50),
                TextButton(
                    onPressed: () {
                      controller.getRes();
                    },
                    child: Text('تحديث الصفحة'.tr)),
                const SizedBox(height: 20),
                if (controller.statusRequest == StatusRequest.loading)
                  const CircularProgressIndicator(),
                const SizedBox(height: 10),
                GoHomeButton(onTap: () => controller.goHomeScreen())
              ],
            ));
  }
}
