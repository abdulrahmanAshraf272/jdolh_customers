import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/image_name_followers.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/scheduled_rating.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class BrandProfileHeader extends StatelessWidget {
  const BrandProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.27,
        width: Get.width,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/breakfastDishe24.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(0.4),
                height: Get.height * 0.1,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Row(
                  children: [
                    Expanded(child: BrandImageNameFollowers()),
                    BrandScheduledAndRating(),
                    //TODO: Edit Follow widget, not responsive
                    //FollowAndBranshedButtons(),
                    SizedBox(width: 7),
                    SizedBox(
                        height: 35,
                        child: CustomButton(onTap: () {}, text: 'المتابعة'))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
