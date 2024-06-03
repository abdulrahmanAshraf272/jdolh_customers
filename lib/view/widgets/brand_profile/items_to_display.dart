import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class ItemsToDisplay extends StatelessWidget {
  const ItemsToDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandProfileController>(
        builder: (controller) => ListView.builder(
            itemCount: controller.itemsToDisplay.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 20),
            itemBuilder: (context, index) => ServiceListItem(
                  image: controller.itemsToDisplay[index].itemsImage,
                  name: controller.itemsToDisplay[index].itemsTitle ?? '',
                  isService:
                      controller.brand.brandIsService == 1 ? true : false,
                  desc: controller.itemsToDisplay[index].itemsDesc ?? '',
                  discount: controller.itemsToDisplay[index].itemsDiscount ?? 0,
                  discountPercent: controller
                          .itemsToDisplay[index].itemsDiscountPercentage ??
                      0,
                  price: controller.itemsToDisplay[index].itemsPrice == 0
                      ? 'السعر حسب الإختيار'
                      : '${controller.itemsToDisplay[index].itemsPrice} ريال',
                  onTap: () {
                    controller.onTapItem(index);
                  },
                  duration: controller.itemsToDisplay[index].itemsDuration ?? 0,
                )));
  }
}

class ServiceListItem extends StatelessWidget {
  final String? image;
  final String name;
  final String price;
  final int duration;
  final String desc;
  final int discount;
  final int discountPercent;
  final void Function() onTap;
  final bool isService;
  const ServiceListItem(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.duration,
      required this.onTap,
      required this.discount,
      required this.discountPercent,
      required this.isService,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    String discountString = discount != 0
        ? 'خصم $discount ريال'
        : discountPercent != 0
            ? 'خصم $discountPercent%'
            : '';
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 90.h,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 85.h,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            AutoSizeText(
                              name,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 5),
                            isService
                                ? Text(
                                    '$duration دقيقة',
                                    style: titleSmall2,
                                  )
                                : AutoSizeText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    desc,
                                    style: titleSmallGray,
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Expanded(
                      //     child: Text(
                      //   '$price ريال',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: 11.sp,
                      //     color: AppColors.textDark,
                      //   ),
                      // )),
                      // CustomButton(
                      //   onTap: onTap,
                      //   text: 'اضف للحجز',
                      //   height: 25.h,
                      // )
                    ],
                  ),
                ),
              ),
              if (discountString != '')
                Positioned(
                  top: 0,
                  left: 3,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.secondaryColor),
                    child: Text(
                      discountString,
                      style: TextStyle(fontSize: 9.sp, color: Colors.white),
                    ),
                  ),
                )
            ],
          ),
        ));
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
