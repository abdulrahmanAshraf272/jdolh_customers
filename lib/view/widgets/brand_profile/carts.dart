import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_product/oreder_content_list_item.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_service/cart_list_item.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandProfileController>(
      builder: (controller) => HandlingDataRequest(
        statusRequest: controller.statusRequestCart,
        widget: controller.carts.isEmpty
            ? const ListIsEmptyText(isService: false)
            : ListView.builder(
                itemCount: controller.carts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => OrderContentCreationListItem(
                    image: controller.carts[index].itemsImage,
                    name: controller.carts[index].itemsTitle ?? '',
                    desc: controller.carts[index].cartShortDesc ?? '',
                    quantity: controller.carts[index].cartQuantity ?? 1,
                    price: controller.carts[index].cartTotalPrice.toString(),
                    onTapIncrease: () {
                      controller.onTapIncrease(index);
                    },
                    onTapDecrease: () {
                      controller.onTapDecrease(index);
                    },
                    onTapDelete: () {
                      controller.deleteCart(index);
                    }),
              ),
      ),
    );
  }
}

class CartService extends StatelessWidget {
  const CartService({super.key});

  @override
  Widget build(BuildContext context) {
    //BrandProfileController controller = Get.find();
    return GetBuilder<BrandProfileController>(
      builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequestCart,
          widget: controller.carts.isEmpty
              ? const ListIsEmptyText(isService: true)
              : ListView.builder(
                  itemCount: controller.carts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CartListItem(
                      image: controller.carts[index].itemsImage,
                      name: controller.carts[index].itemsTitle ?? '',
                      desc: controller.carts[index].cartShortDesc ?? '',
                      price: controller.carts[index].cartTotalPrice.toString(),
                      duration: controller.carts[index].itemsDuration ?? 0,
                      onTapDelete: () {
                        controller.deleteCart(index);
                      }),
                )),
    );
  }
}

class ListIsEmptyText extends StatelessWidget {
  final bool isService;
  const ListIsEmptyText({
    super.key,
    required this.isService,
  });

  @override
  Widget build(BuildContext context) {
    String message =
        isService ? 'قم باضافة بعض المنتجات' : 'قم باضافة بعض الخدمات';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: 'السلة فارغة !\n',
                  style: TextStyle(
                      color: AppColors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                TextSpan(
                    text: message,
                    style: TextStyle(
                        color: AppColors.black.withOpacity(0.4),
                        fontSize: 14,
                        fontFamily: 'Cairo'))
              ])),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
