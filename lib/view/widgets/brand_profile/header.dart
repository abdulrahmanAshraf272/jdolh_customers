import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/image_name_followers.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/scheduled_rating.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/arrow_back_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class BrandProfileHeader extends StatelessWidget {
  final bool isFollowing;
  final void Function() onTapFollow;
  const BrandProfileHeader(
      {super.key, required this.onTapFollow, required this.isFollowing});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandProfileController>(
        builder: (controller) => SizedBox(
            height: Get.height * 0.27,
            width: Get.width,
            child: Stack(
              children: [
                Positioned.fill(
                  child: controller.bch.bchImage != null
                      ? FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading2.gif',
                          image:
                              '${ApiLinks.branchImage}/${controller.bch.bchImage!}',
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/noImageAvailable.jpg',
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: BrandImageNameFollowers(
                                brandName:
                                    controller.brand.brandStoreName ?? '',
                                logoImage:
                                    '${ApiLinks.logoImage}/${controller.brand.brandLogo!}',
                                isVerified:
                                    controller.brand.brandIsVerified ?? 0,
                                followrsNo: 0)),
                        const BrandScheduledAndRating(
                          scheduledNo: 0,
                          ratedBy: 0,
                          rate: 0,
                        ),
                        //TODO: Edit Follow widget, not responsive
                        const SizedBox(width: 7),
                        SizedBox(
                            height: 35,
                            child: isFollowing
                                ? CustomButton(
                                    onTap: onTapFollow,
                                    text: 'الغاء المتابعة',
                                    buttonColor: AppColors.redButton,
                                  )
                                : CustomButton(
                                    onTap: onTapFollow, text: 'المتابعة'))
                      ],
                    ),
                  ),
                ),
                const Positioned(
                    top: 0,
                    right: 10,
                    child: SafeArea(
                      child: ArrowBackButton(),
                    ))
              ],
            )));
  }
}
