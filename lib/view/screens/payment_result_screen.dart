import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/payment_result_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';

class PaymentResultScreen extends StatelessWidget {
  const PaymentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentResultController());
    return Scaffold(
      body: GetBuilder<PaymentResultController>(
          builder: (controller) => SafeArea(
                child: controller.result == '' &&
                        controller.paymentMethod == 'credit'
                    ? const Center(child: CircularProgressIndicator())
                    : controller.paymentMethod == 'wallet' ||
                            controller.result == 'success'
                        ? const ReservationConfirmed()
                        : const Center(child: PaymentFailed()),
              )),
    );
  }
}

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
          size: 100,
        ),
        Text(
          'عملية دفع غير ناجحة',
          style: titleLarge,
        ),
        const SizedBox(height: 30),
        GoHomeButton(onTap: () {
          Get.offAllNamed(AppRouteName.mainScreen);
        })
      ],
    );
  }
}

class ReservationConfirmed extends StatelessWidget {
  const ReservationConfirmed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentResultController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Icon(Icons.check_circle_outline,
                  size: 150.h, color: AppColors.secondaryColor)),
          const SizedBox(height: 10),
          Text(
            'تهانينا, تم تأكيد الحجز',
            style: titleLarge,
          ),
          const SizedBox(height: 10),
          Text('شكراً لاختيارك جدولة', style: titleMedium),
          const SizedBox(height: 10),
          const Divider(thickness: 1, endIndent: 20, indent: 20),
          const SizedBox(height: 10),
          Text(
            '${controller.brand.brandStoreName}',
            style: titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            controller.reservation.bchLocation ?? '',
            style: titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          DisplayDetails(
            title:
                'وقت الحجز: ${controller.reservation.resDate} - الساعة: ${controller.reservationTime}',
            color: AppColors.gray,
            onTap: () {},
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: DisplayDetails(
                  title: 'مشاركة عنوان الفرع',
                  color: AppColors.secondaryColor300,
                  onTap: () => controller.onTapShareLocation(),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: DisplayDetails(
                  title: 'عرض على الخريطة',
                  color: AppColors.secondaryColor300,
                  onTap: () => controller.onTapDisplayLocation(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GoHomeButton(onTap: () {
            Get.offAllNamed(AppRouteName.mainScreen);
          })
        ],
      ),
    );
  }
}

class DisplayDetails extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color color;
  const DisplayDetails({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: AutoSizeText(maxLines: 1, title),
    );
  }
}
