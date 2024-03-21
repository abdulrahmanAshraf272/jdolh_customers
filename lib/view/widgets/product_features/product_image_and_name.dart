import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class ProductImageAndName extends StatelessWidget {
  final String? image;
  final String name;
  const ProductImageAndName({
    super.key,
    required this.image,
    required this.name,
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
                  width: Get.width - 40,
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: AutoSizeText(
                    name,
                    style: titleMedium.copyWith(
                        color: AppColors.white, fontSize: 18.sp),
                    maxLines: 2,
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: SafeArea(
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Get.back();
                      }),
                ))
          ],
        ));
  }
}
