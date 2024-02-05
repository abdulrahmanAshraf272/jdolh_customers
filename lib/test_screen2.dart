import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_button_one_option.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class TestScreen2 extends StatelessWidget {
  const TestScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'title'),
      body: Column(
        children: [
          ProductImageAndName(),
          CustomTitle(
            title: 'الحجم',
            customTextStyle: titleLargeNotBold,
            topPadding: 20,
            bottomPadding: 10,
          ),
          SelectSize()
        ],
      ),
    );
  }
}

class SelectSize extends StatefulWidget {
  const SelectSize({
    super.key,
  });

  @override
  State<SelectSize> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  int selectedIndex = 0;
  List<String> list = ['كبير', 'متوسط', 'صغير'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (context, index) => toggleButtonItem(index)),
    );
  }

  Widget toggleButtonItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Row(
        children: [
          Container(
            height: 18,
            width: 18,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.5)),
                shape: BoxShape.circle,
                color: const Color(0xffF3F3F3)),
            child: Center(
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == index
                        ? AppColors.secondaryColor
                        : null),
              ),
            ),
          ),
          Text(list[index],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.grayText,
              )),
        ],
      ),
    );
  }
}

class ProductImageAndName extends StatelessWidget {
  const ProductImageAndName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.25,
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              'assets/images/breakfastDishe24.jpg',
              fit: BoxFit.cover,
            )),
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
                    'بان كيك',
                    style: titleMedium.copyWith(
                        color: AppColors.white, fontSize: 18.sp),
                    maxLines: 2,
                  ),
                ))
          ],
        ));
  }
}

class FlixableToggleButton extends StatefulWidget {
  final List<String> list;
  final double cirleSize;
  final double fontSize;
  const FlixableToggleButton(
      {super.key, required this.list, this.cirleSize = 16, this.fontSize = 11});

  @override
  State<FlixableToggleButton> createState() => _FlixableToggleButtonState();
}

class _FlixableToggleButtonState extends State<FlixableToggleButton> {
  int selectedIndex = 0;
  //List<String> list = ['كبير', 'متوسط', 'صغير'];
  @override
  Widget build(BuildContext context) {
    print('=========ssss======');
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.list.length,
        itemBuilder: (context, index) => toggleButtonItem(index));
  }

  Widget toggleButtonItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Row(
        children: [
          Container(
            height: widget.cirleSize,
            width: widget.cirleSize,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.5)),
                shape: BoxShape.circle,
                color: const Color(0xffF3F3F3)),
            child: Center(
              child: Container(
                height: widget.cirleSize,
                width: widget.cirleSize,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == index
                        ? AppColors.secondaryColor
                        : null),
              ),
            ),
          ),
          Text(widget.list[index],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: widget.fontSize.sp,
                color: AppColors.grayText,
              )),
        ],
      ),
    );
  }
}
