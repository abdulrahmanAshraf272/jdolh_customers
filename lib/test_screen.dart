// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_toggle.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_toggle_buttons.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppointmentListItem(),
            AppointmentListItemNotApproved(),
            ActivityListItem(),
            PersonListItem(),
            PersonWithTextListItem(),
            PersonWithButtonListItem(),
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
              onTap: () {},
              text: 'دعوة',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final double? h;
  final double? w;
  final String? iconDirection;
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.h,
      this.w,
      this.iconDirection});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add),
            Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((state) {
              if (state.contains(MaterialState.pressed)) {
                return AppColors.secondaryColorLight;
              }
              return AppColors.secondaryColor;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
      ),
    );
  }
}
