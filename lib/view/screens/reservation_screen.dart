import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/address_title.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';

import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'الحجز',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CustomSmallTitle(title: 'القسم'),
          CustomDropdownButton(
              width: Get.width * 0.65,
              horizontalPadding: 20,
              verticalPadding: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                children: [
                  const CustomSmallTitle(
                    title: 'نوع المطعم',
                    rightPdding: 0,
                    leftPadding: 0,
                  ),
                  CustomDropdownButton(verticalPadding: 10),
                ],
              )),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                children: [
                  CustomSmallTitle(
                    title: 'المدينة',
                    rightPdding: 0,
                    leftPadding: 0,
                  ),
                  CustomDropdownButton(verticalPadding: 10),
                ],
              )),
              const SizedBox(width: 20),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: BottomButton(
                onTap: () {},
                text: 'بحث',
                buttonColor: AppColors.secondaryColor,
              ),
            ),
          ),
          AddressTitle(addressTitle: 'النتائج-25', onTap: () {}),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 9,
                itemBuilder: (context, index) => BrandDetailedListItem()),
          ),
        ],
      ),
    );
  }
}
