import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/guaranteed_icon.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class BrandDetailedListItem extends StatelessWidget {
  final String brandName;
  final String type;
  final String subtype;
  final String address;
  final double rate;
  final int isVerified;
  final String? image;
  final void Function() onTap;
  final int? resCount;
  const BrandDetailedListItem(
      {super.key,
      required this.brandName,
      required this.type,
      required this.subtype,
      required this.address,
      required this.rate,
      required this.isVerified,
      required this.image,
      required this.onTap,
      this.resCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [boxShadow1]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image != null
                        ? FadeInImage.assetNetwork(
                            width: 84.w,
                            height: 84.w,
                            placeholder: 'assets/images/loading2.gif',
                            image: image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/noImageAvailable.jpg',
                            fit: BoxFit.cover,
                            width: 84.w,
                            height: 84.w,
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      AutoSizeText(brandName,
                                          maxLines: 1,
                                          minFontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                          style: titleMedium),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GuaranteedIcon(
                                          active:
                                              isVerified == 1 ? true : false)
                                    ],
                                  ),
                                  AutoSizeText(
                                    '$type, $subtype',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: titleSmallGray,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            resCount != null
                                ? Row(
                                    children: [
                                      Text(
                                        '$resCount',
                                        style: titleSmall,
                                      ),
                                      const Icon(Icons.person)
                                    ],
                                  )
                                : rate != 0
                                    ? Rating(rating: rate)
                                    : const SizedBox()
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: titleSmallGray,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
