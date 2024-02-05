import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/food.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_toggle.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/extra_fee_list_item.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price_with_fee.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_button_one_option.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/guaranteed_icon.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'جدولة',
      ),
      floatingActionButton: BottomButton(onTap: () {}, text: 'تأكيد الحجز'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandProfileHeader(),
            LargeToggleButtons(
                optionOne: 'قائمة الطعام',
                optionTwo: 'تفاصيل الحجز',
                onTapOne: () {},
                onTapTwo: () {}),
            SizedBox(height: 16),
            ReservationOptionsAndExtraSeats(),
            CustomTitle(
              title: 'وقت الحجز',
              topPadding: 20,
              customTextStyle: titleMedium,
            ),
            ReservationDateDisplay(),
            CustomToggleButtonsOneOption(
              firstOption: 'ارسال دعوة',
              onTapOne: () {},
              secondOption: 'بدون دعوة',
              onTapTwo: () {},
              horizontalPadding: 20,
              verticalPadding: 10,
            ),
            Invitors(),
            CustomTitle(
              title: 'تفاصيل الطلب',
              topPadding: 20,
              customTextStyle: titleMedium,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 0),
                itemCount: 3,
                itemBuilder: (context, index) =>
                    OrderContentCreationListItem()),
            OrderTotalPrice(),
            SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 0),
                itemCount: 3,
                itemBuilder: (context, index) => OrderExtraFeeListItem()),
            OrderTotalPriceWithFees(),
            SizedBox(height: 80)
          ],
        ),
      ),
    );
  }
}

class OrderContentCreationListItem extends StatelessWidget {
  const OrderContentCreationListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            color: AppColors.gray400,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/avatar_person.jpg',
                    height: 32.h,
                    width: 32.h,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AutoSizeText('ورق عنب',
                        maxLines: 2,
                        minFontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        style: titleSmall),
                    Text('35 ريال',
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
              height: 50.h,
              color: AppColors.gray300,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(onTap: () {}, text: '+'),
                  Text(
                    '1',
                    style: titleMedium,
                  ),
                  CustomButton(onTap: () {}, text: '+'),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'ازالة',
                        style: titleSmall.copyWith(color: AppColors.redButton),
                      )),
                ],
              )),
        ),
      ],
    );
  }
}

class Invitors extends StatelessWidget {
  const Invitors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 20),
            AutoSizeText(
              'المضافين للدعوة',
              maxLines: 1,
              style: titleMedium,
            ),
            Spacer(),
            CustomButton(onTap: () {}, text: '+ أضف للدعوة'),
            SizedBox(width: 20),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: 1,
            itemBuilder: (context, index) => PersonWithToggleListItem()),
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
        ),
      ],
    );
  }
}

class ReservationDateDisplay extends StatelessWidget {
  const ReservationDateDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        //border: Border.all(color: Colors.black26),
        color: AppColors.gray,
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(
            'اختر وقت الحجز',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
              color: Colors.grey.shade500,
            ),
          )),
          Icon(
            Icons.date_range_outlined,
            color: Colors.grey.shade500,
          )
        ],
      ),
    );
  }
}

class ReservationOptionsAndExtraSeats extends StatelessWidget {
  const ReservationOptionsAndExtraSeats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                CustomTitle(
                  title: 'خيارات الحجز',
                  bottomPadding: 10,
                  rightPdding: 0,
                  leftPadding: 0,
                  customTextStyle: titleMedium,
                ),
                CustomDropdownButton()
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                CustomTitle(
                  title: 'مقاعد اضافية',
                  bottomPadding: 10,
                  rightPdding: 0,
                  leftPadding: 0,
                  customTextStyle: titleMedium,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    //border: Border.all(color: Colors.black26),
                    color: AppColors.gray,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: const TextStyle(fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 30),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsSubScreen extends StatelessWidget {
  const ProductsSubScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 45,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(right: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) => CategoriesListItem()),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) => FoodListItem(),
          ))
        ],
      ),
    );
  }
}

class CategoriesListItem extends StatelessWidget {
  const CategoriesListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معجنات',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.secondaryColor,
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 2,
            width: 20,
            color: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}

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
                    FollowAndBranshedButtons()
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class FollowAndBranshedButtons extends StatelessWidget {
  const FollowAndBranshedButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(onTap: () {}, text: 'الغاء المتابعة'),
        Spacer(),
        SizedBox(
            width: 100,
            child: CustomDropdownButton(
              buttonHeight: 28,
            ))
      ],
    );
  }
}

class BrandScheduledAndRating extends StatelessWidget {
  const BrandScheduledAndRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '120 مجدولين',
              style: titleSmall3Gray.copyWith(color: AppColors.secondaryColor),
            ),
            Icon(
              Icons.person,
              color: AppColors.secondaryColor,
              size: 20,
            )
          ],
        ),
        Spacer(),
        Row(
          children: [
            Text(
              '120 تقييم',
              style: titleSmall3Gray,
            ),
            SizedBox(width: 3),
            Rating(
              rating: 4.5,
              textColor: Colors.white.withOpacity(0.7),
            )
          ],
        ),
      ],
    );
  }
}

class BrandImageNameFollowers extends StatelessWidget {
  const BrandImageNameFollowers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/avatar_person.jpg',
            height: 42.h,
            width: 42.h,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AutoSizeText('مطعم البيك',
                    maxLines: 1,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleMediumWhite),
                SizedBox(
                  width: 5,
                ),
                GuaranteedIcon(active: true)
              ],
            ),
            Spacer(),
            Text('849-متابعين', style: titleSmall3Gray)
          ],
        ),
      ],
    );
  }
}
