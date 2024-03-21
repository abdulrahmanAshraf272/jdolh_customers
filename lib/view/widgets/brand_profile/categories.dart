import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandProfileController>(
        builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 25.h,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(right: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) => CategoriesListItem(
                        index: index,
                        selectedIndex: controller.selectedIndexCategory,
                        text: controller.categories[index].title ?? '',
                        onTap: () {
                          controller.onTapCategory(index);
                        },
                      )),
            ));
  }
}

class CategoriesListItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String text;
  final void Function() onTap;
  const CategoriesListItem(
      {super.key,
      required this.index,
      required this.text,
      required this.selectedIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: selectedIndex == index
                    ? AppColors.secondaryColor
                    : Colors.grey,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              height: 2,
              width: 20,
              color: selectedIndex == index ? AppColors.secondaryColor : null,
            ),
          ],
        ),
      ),
    );
  }
}
