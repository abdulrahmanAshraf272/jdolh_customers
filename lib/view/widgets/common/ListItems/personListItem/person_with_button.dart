import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_name_image.dart';

class PersonWithButtonListItem extends StatelessWidget {
  final String name;
  final String userName;
  final String? image;
  final Function() onTap;
  final Function()? onTapCard;
  final Color buttonColor;
  final String buttonText;
  final double horizontalPadding;
  final bool isThisMe;

  const PersonWithButtonListItem(
      {super.key,
      required this.name,
      required this.onTap,
      this.buttonColor = AppColors.secondaryColor,
      this.buttonText = 'إضافة',
      required this.userName,
      required this.image,
      this.horizontalPadding = 20,
      required this.onTapCard,
      this.isThisMe = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isThisMe ? null : onTapCard,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: image != '' && image != null
                                ? FadeInImage.assetNetwork(
                                    height: 34.w,
                                    width: 34.w,
                                    placeholder: 'assets/images/loading2.gif',
                                    image: '${ApiLinks.customerImage}/$image',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/person4.jpg',
                                    fit: BoxFit.cover,
                                    height: 34.w,
                                    width: 34.w,
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(name,
                                    maxLines: 1,
                                    minFontSize: 11,
                                    overflow: TextOverflow.ellipsis,
                                    style: titleSmall),
                                Text(userName, style: titleSmallGray)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: isThisMe ? null : onTap,
                      child: Text(
                        isThisMe ? '' : buttonText.tr,
                        style: titleSmall2.copyWith(color: buttonColor),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
