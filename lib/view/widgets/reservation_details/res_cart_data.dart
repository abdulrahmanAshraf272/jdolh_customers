import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/schedule/reservation_details_controller.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/cart_product.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/cart_service.dart';

class ResCartData extends StatelessWidget {
  const ResCartData({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ReservationDetailsController());
    return GetBuilder<ReservationDetailsController>(
        builder: (controller) => controller.isService
            ? Column(
                children: [
                  CustomTitle(title: 'الخدمات'.tr),
                  CartService(
                    statusRequest: controller.statusRequest,
                    carts: controller.carts,
                  ),
                ],
              )
            : Column(
                children: [
                  CustomTitle(title: 'تفاصيل الطلب'.tr),
                  const SizedBox(height: 15),
                  const OrderContentTitle(),
                  CartProduct(
                    statusRequest: controller.statusRequest,
                    carts: controller.carts,
                  ),
                ],
              ));
  }
}
