import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

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
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSmallCard(
              title: 'اوقات العمل'.tr,
              onTapCard: onTapWorktime,
            ),
            const SizedBox(width: 15),
            CustomSmallCard(
              title: 'الفروع'.tr,
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
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapCard,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          ),
        ),
      ),
    );
  }
}
