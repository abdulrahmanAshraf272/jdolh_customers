import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';

class DescAndBranshedButtonAndWorkTime extends StatelessWidget {
  final String desc;
  final void Function() onTapWorktime;
  final void Function() onTapBchs;
  const DescAndBranshedButtonAndWorkTime({
    super.key,
    required this.desc,
    required this.onTapWorktime,
    required this.onTapBchs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Row(
          children: [
            CustomSmallCard(
              title: 'مواعيد العمل',
              onTapCard: onTapWorktime,
            ),
            const SizedBox(width: 15),
            CustomSmallCard(
              title: 'الفروع',
              onTapCard: onTapBchs,
            ),
          ],
        ),
        const SizedBox(height: 10),
        AutoSizeText(
          desc,
          maxLines: 4,
        )
      ]),
    );
  }
}

class CustomSmallCard extends StatelessWidget {
  final String title;
  final void Function() onTapCard;
  const CustomSmallCard({
    super.key,
    required this.title,
    required this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCard,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: AppColors.gray, borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              AutoSizeText(title),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 15,
              )
            ],
          )),
    );
  }
}
