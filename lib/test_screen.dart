// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';

import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/bill.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_explore.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/comment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/food.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/group.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/haircut_service.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_toggle.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/person_explore.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/wallet_operation.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/appt_number_and_date.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.gray,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDropdownButton(),
            AppointmentNumberAndDate(
              date: '3:00 15/3/2022',
              number: 132,
            ),
            PersonExploreListItem(),
            BrandExploreListItem(),
            CustomTitle(
              title: 'جدولك القادم',
              onTap: () {},
            ),
            //OccasionListItem(),
            //GroupListItem(),
            WalletOperationListItem(),
            HairCutServiceListItem(),
            BillListItem(paid: false),
            FoodListItem(),
            //BrandDetailedListItem(),
            Brand(),
            CommentListItem(),
            AppointmentListItemNotApproved(),
            AppointmentListItem(onTap: () {
              Get.toNamed(AppRouteName.apptDetails);
            }),
            ActivityListItem(),
            PersonListItem(),

            //PersonWithToggleListItem(),
            LargeToggleButtons(
              optionOne: 'مواعيد قريبة',
              onTapOne: () {},
              optionTwo: 'بحاجة لموافقتك',
              onTapTwo: () {},
              twoColors: true,
            ),
            LargeToggleButtons(
              optionOne: 'مواعيد قريبة',
              onTapOne: () {},
              optionTwo: 'بحاجة لموافقتك',
              onTapTwo: () {},
            ),
            ConfirmRefuseButtons(
              onTapConfirm: () {},
              onTapRefuse: () {},
            ),
            BottomButton(
              text: 'الدفع',
              onTap: () {},
            ),
            CustomButton(
              text: 'الصفحة',
              onTap: () {},
              size: 1,
            )
          ],
        ),
      ),
    );
  }
}
