import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ApptScreen extends StatelessWidget {
  const ApptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'مواعيدك', onTapSearch: () {}),
      body: Column(
        children: [
          LargeToggleButtons(
            optionOne: 'مواعيد قريبة',
            onTapOne: () {},
            optionTwo: 'بحاجة لموافقتك',
            onTapTwo: () {},
            twoColors: true,
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => AppointmentListItem(
                      onTap: () {
                        Get.toNamed(AppRouteName.apptDetails);
                      },
                    )),
          ),
        ],
      ),
    );
  }
}
