import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        color: AppColors.gray,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'ابحث في قائمة الأصدقاء',
                hintStyle: const TextStyle(fontSize: 14),
                // contentPadding: const EdgeInsets.symmetric(
                //     vertical: 5, horizontal: 30),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
