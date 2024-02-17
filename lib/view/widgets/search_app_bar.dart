import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class SearchAppBar extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function() onTapSearch;
  final bool withArrowBack;
  final bool autoFocus;
  final String hintText;
  const SearchAppBar(
      {super.key,
      required this.onTapSearch,
      this.withArrowBack = true,
      this.autoFocus = false,
      required this.textEditingController,
      this.hintText = 'اكتب اسم الشخص'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SafeArea(
        child: Row(
          children: [
            withArrowBack
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ))
                : SizedBox(),
            TextButton(
                onPressed: onTapSearch,
                child: Text(
                  'بحث',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                )),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                  color: AppColors.white,
                ),
                child: TextFormField(
                  controller: textEditingController,
                  autofocus: autoFocus,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
