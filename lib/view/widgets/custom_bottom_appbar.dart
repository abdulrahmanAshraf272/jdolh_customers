import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        //padding: const EdgeInsets.symmetric(vertical: 7),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: BottomAppBarItem(
                  index: 0, title: 'الرئيسية'.tr, iconData: Icons.home),
            ),
            Expanded(
              child: BottomAppBarItem(
                  index: 1, title: 'جدولة'.tr, iconData: Icons.task),
            ),
            SizedBox(width: 40.w),
            Expanded(
              child: BottomAppBarItem(
                  index: 2, title: 'الحجز'.tr, iconData: Icons.date_range),
            ),
            Expanded(
              child: BottomAppBarItem(
                  index: 3, title: 'المزيد'.tr, iconData: Icons.more_outlined),
            ),
          ],
        ));
  }
}

class BottomAppBarItem extends StatelessWidget {
  final int index;
  final String title;
  final IconData iconData;
  const BottomAppBarItem(
      {super.key,
      required this.index,
      required this.title,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        builder: (controller) => ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: MaterialButton(
                  onPressed: () {
                    controller.changePage(index);
                  },
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        iconData,
                        color: controller.currentPage == index
                            ? AppColors.secondaryColor
                            : Colors.grey,
                        size: 30,
                      ),
                      AutoSizeText(
                        title,
                        maxLines: 1,
                        style: titleSmall.copyWith(
                            fontSize: 11.sp,
                            color: controller.currentPage == index
                                ? AppColors.secondaryColor
                                : Colors.grey),
                      )
                    ],
                  )),
            ));
  }
}
