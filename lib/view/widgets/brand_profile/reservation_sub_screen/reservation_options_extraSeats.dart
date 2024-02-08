import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

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
