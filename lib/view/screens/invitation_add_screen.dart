import 'package:auto_size_text/auto_size_text.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/test_screen.dart';
import 'package:jdolh_customers/view/screens/appt_screen.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/food.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_toggle.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/address_title.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/appt_number_and_date.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/extra_fee_list_item.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price_with_fee.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_button_one_option.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/guaranteed_icon.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';
import 'package:jdolh_customers/view/widgets/common/search_textfield.dart';

class InvitationAddScreen extends StatelessWidget {
  const InvitationAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('=========ssss======');
    return Scaffold(
      appBar: customAppBar(
        title: 'اضف للدعوة',
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.gray,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) => AddGroupIconListItem(),
            ),
          ),
          SizedBox(height: 15),
          SearchTextField(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: 6,
              itemBuilder: (context, index) => PersonWithButtonListItem(
                name: 'عبدالرحمن',
                onTap: () {
                  // Get.to(() => ApptScreen())!.then((value) {
                  //   setState(() {});
                  // });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddGroupIconListItem extends StatelessWidget {
  const AddGroupIconListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.groups,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor, shape: BoxShape.circle),
                  child: AutoSizeText(
                    '+',
                    maxLines: 1,
                    style: titleSmallGray.copyWith(color: Colors.white),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 3),
          Text(
            'قروب الاستراحة',
            style: titleSmall,
          )
        ],
      ),
    );
  }
}
