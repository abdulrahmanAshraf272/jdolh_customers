// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/bill.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_explore.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/comment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/event.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/food.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/group.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/haircut_service.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_toggle.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/person_explore.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/wallet_operation.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/custom_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

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
            EventListItem(),
            GroupListItem(),
            WalletOperationListItem(),
            HairCutServiceListItem(),
            BillListItem(paid: false),
            FoodListItem(),
            BrandDetailed(),
            Brand(),
            CommentListItem(),
            AppointmentListItemNotApproved(),
            AppointmentListItem(),
            ActivityListItem(),
            PersonListItem(),
            PersonWithTextListItem(),
            PersonWithButtonListItem(
              name: 'عبدالرحمن',
              onTap: () {},
            ),
            PersonWithToggleListItem(),
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

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Icon(
              Icons.restaurant,
              size: 16,
              color: AppColors.gray600,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'المطاعم',
                style: titleSmall.copyWith(color: AppColors.gray600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: titleSmall.copyWith(color: AppColors.gray600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            //border: Border.all(color: Colors.black26),
            color: AppColors.gray,
          ),
          //elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 18,
          iconEnabledColor: AppColors.gray600,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.gray,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

class AppointmentNumberAndDate extends StatelessWidget {
  final int number;
  final String date;
  const AppointmentNumberAndDate({
    super.key,
    required this.number,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 42.h,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.secondaryColor300,
                borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: AppColors.secondaryColor,
                  size: 23,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: AutoSizeText(date,
                      maxLines: 1, minFontSize: 3, style: titleSmall),
                ),
              ],
            ),
          )),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 42.h,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor300,
                  borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: [
                  Text('#',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: AppColors.secondaryColor,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Text('رقم الحجز:', style: titleSmall),
                  SizedBox(width: 4),
                  Text('$number',
                      style: titleSmall.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
