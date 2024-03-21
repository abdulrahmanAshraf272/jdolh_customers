import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandProfileController>(
        builder: (controller) => ListView.builder(
              itemCount: controller.itemsToDisplay.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => ProductListItem(
                image: controller.itemsToDisplay[index].itemsImage,
                name: controller.itemsToDisplay[index].itemsTitle ?? '',
                price: controller.itemsToDisplay[index].itemsPrice == 0
                    ? ''
                    : controller.itemsToDisplay[index].itemsPrice.toString(),
                onTap: () {
                  controller.onTapItem(index);
                },
              ),
            ));
  }
}

class ServiceListItem extends StatelessWidget {
  final String? image;
  final String name;
  final String price;
  final int duration;
  final void Function() onTap;
  const ServiceListItem(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.duration,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image != null
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading2.gif',
                    image: '${ApiLinks.itemsImage}/$image',
                    width: 100.w,
                    height: 75,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/noImageAvailable.jpg',
                    height: 75,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  name,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  '$duration دقيقة',
                  style: titleSmall2,
                )
              ],
            ),
          ),
          SizedBox(width: 3),
          Expanded(
              child: Text(
            '$price ريال',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              color: AppColors.textDark,
            ),
          )),
          CustomButton(
            onTap: onTap,
            text: 'اضف للحجز',
            height: 30.h,
          )
        ],
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final void Function() onTap;
  final String? image;
  final String name;
  final String price;
  const ProductListItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: Get.width - 40,
          height: 140.h,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Stack(
            children: [
              Positioned.fill(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: image != null
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading2.gif',
                        image: '${ApiLinks.itemsImage}/$image',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/noImageAvailable.jpg',
                        fit: BoxFit.cover,
                      ),
              )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent
                          ])),
                ),
              ),
              Positioned(
                  bottom: 15,
                  child: Container(
                    width: Get.width - 40,
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            name,
                            style: titleMedium.copyWith(
                                color: AppColors.white, fontSize: 16.sp),
                            maxLines: 2,
                          ),
                        ),
                        Text(price,
                            style: titleMedium.copyWith(
                                color: AppColors.secondaryColor,
                                fontSize: 16.sp))
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
