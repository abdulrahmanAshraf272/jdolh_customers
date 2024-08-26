import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class OccasionListItem extends StatelessWidget {
  final String from;
  final String title;
  final String date;
  final String location;
  final void Function() onTapAccept;
  final void Function() onTapReject;
  final int creator;
  final void Function() onTapCard;
  const OccasionListItem(
      {super.key,
      required this.from,
      required this.title,
      required this.date,
      required this.location,
      required this.onTapAccept,
      required this.onTapReject,
      required this.creator,
      required this.onTapCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapCard,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: _titleDataLocationFromWho(
                        from: from,
                        title: title,
                        date: date,
                        location: location,
                        creator: creator),
                  ),
                  Column(
                    children: [
                      CustomButton(
                        onTap: onTapAccept,
                        text: 'قبول'.tr,
                        size: 1.15,
                        buttonColor: AppColors.secondaryColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: onTapReject,
                        text: 'اعتذار'.tr,
                        size: 1.15,
                        buttonColor: AppColors.redButton,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OccasionAcceptedListItem extends StatelessWidget {
  final String from;
  final String title;
  final String date;
  final String location;
  final int creator;
  final void Function() onTapOpenLocation;
  final void Function() onTapCard;
  const OccasionAcceptedListItem(
      {super.key,
      required this.from,
      required this.title,
      required this.date,
      required this.location,
      required this.creator,
      required this.onTapOpenLocation,
      required this.onTapCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapCard,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: _titleDataLocationFromWho(
                        from: from,
                        title: title,
                        date: date,
                        location: location,
                        creator: creator),
                  ),
                  CustomButton(
                    onTap: onTapOpenLocation,
                    text: 'فتح الموقع'.tr,
                    size: 1.15,
                    buttonColor: AppColors.secondaryColor300,
                    textColor: AppColors.textDark,
                    iconData: Icons.pin_drop_outlined,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Column _titleDataLocationFromWho(
    {required String title,
    required String date,
    required String location,
    required String from,
    required int creator}) {
  String headerText =
      creator == 0 ? '${'مناسبة من'.tr} $from' : 'مناسبة شخصية'.tr;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AutoSizeText(headerText,
          maxLines: 1,
          minFontSize: 15,
          overflow: TextOverflow.ellipsis,
          style: titleMedium),
      AutoSizeText(
        '$title $date',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: titleSmall2.copyWith(color: AppColors.grayText),
      ),
      AutoSizeText(
        location,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: titleSmallGray,
      ),
    ],
  );
}
