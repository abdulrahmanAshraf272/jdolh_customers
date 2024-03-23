import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/arrow_back_button.dart';

class ProductImageAndName extends StatelessWidget {
  final String? image;
  final String name;
  final String itemPrice;
  final String itemPriceAfterDiscount;
  const ProductImageAndName({
    super.key,
    required this.image,
    required this.name,
    required this.itemPrice,
    required this.itemPriceAfterDiscount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.25,
        child: Stack(
          children: [
            Positioned.fill(
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
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
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
                  width: Get.width,
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          name,
                          style: titleMedium.copyWith(
                              color: AppColors.white, fontSize: 18.sp),
                          maxLines: 2,
                        ),
                      ),
                      Price(
                        itemPrice: itemPrice,
                        itemPriceAfterDiscount: itemPriceAfterDiscount,
                      )
                    ],
                  ),
                )),
            const Positioned(
                top: 0,
                right: 10,
                child: SafeArea(
                  child: ArrowBackButton(),
                ))
          ],
        ));
  }
}

class Price extends StatelessWidget {
  final String itemPrice;
  final String itemPriceAfterDiscount;
  const Price({
    super.key,
    required this.itemPrice,
    required this.itemPriceAfterDiscount,
  });

  @override
  Widget build(BuildContext context) {
    return itemPrice == '0'
        ? const SizedBox()
        : itemPrice == itemPriceAfterDiscount
            ? Text(
                '$itemPrice ريال',
                style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            : Column(
                children: [
                  Text(
                    '$itemPriceAfterDiscount ريال',
                    style: const TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$itemPrice ريال',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  )
                ],
              );
  }
}
