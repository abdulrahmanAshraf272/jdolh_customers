import 'package:flutter/material.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/address_title.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/appt_brand_name_and_by_who.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/appt_number_and_date.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ApptDetailsScreen extends StatelessWidget {
  const ApptDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'تفاصيل الموعد', onTapSearch: () {}),
      body: Column(
        children: [
          ApptBrandNameAndBywhoAndState(),
          AddressTitle(
            addressTitle: 'الرياض-شارع الصحابة',
            onTap: () {},
          ),
          AppointmentNumberAndDate(
            date: '3:00 15/3/2022',
            number: 132,
          ),
          LargeToggleButtons(
            optionOne: 'المدعوين',
            onTapOne: () {},
            optionTwo: 'تفاصيل الطلب',
            onTapTwo: () {},
            displayNumber: 3,
          ),
          Expanded(
            child: OrderContent(),
          ),
          ConfirmRefuseButtons(onTapConfirm: () {}, onTapRefuse: () {})
        ],
      ),
    );
  }
}
