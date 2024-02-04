import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class BrandDetailed extends StatelessWidget {
  const BrandDetailed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/avatar_person.jpg',
              height: 85.h,
              width: 85.h,
            ),
            const SizedBox(width: 12),
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
                                  AutoSizeText('حجز البيك',
                                      maxLines: 1,
                                      minFontSize: 15,
                                      overflow: TextOverflow.ellipsis,
                                      style: titleMedium),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.secondaryColor),
                                    child: Text(
                                      'j',
                                      style: TextStyle(
                                          color: AppColors.white, fontSize: 9),
                                    ),
                                  )
                                ],
                              ),
                              AutoSizeText(
                                'المطاعم, المشويات',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: titleSmallGray,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Rating(rating: 5.0)
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
                            'الرياض, النظيم-شارع الصحابة',
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
    );
  }
}
