import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class AddressTitle extends StatelessWidget {
  final String addressTitle;
  final void Function() onTap;
  const AddressTitle({
    super.key,
    required this.addressTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(addressTitle, style: titleSmall),
          ),
          Container(
            color: AppColors.gray,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.pin_drop_outlined,
                        size: 18,
                      ),
                      const SizedBox(width: 3),
                      Text('عرض على الخريطة'.tr, style: titleSmall2),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
