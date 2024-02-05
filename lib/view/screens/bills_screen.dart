import 'package:flutter/material.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/bill.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'الفواتير'),
      body: Column(
        children: [
          LargeToggleButtons(
            optionOne: 'مدفوعة',
            optionTwo: 'غير مدفوعة',
            onTapOne: () {},
            onTapTwo: () {},
            twoColors: true,
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 9,
                itemBuilder: (context, index) => BillListItem(paid: true)),
          ),
        ],
      ),
    );
  }
}
