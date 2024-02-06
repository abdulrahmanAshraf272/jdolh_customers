import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/wallet_operation.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class WalletDatailsScreen extends StatelessWidget {
  const WalletDatailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'المحفظة'),
      body: SafeArea(
        child: Column(
          children: [
            //TODO: fix overflow problem when number is big
            HeaderContainer(
              moneyAmount: '693340',
              onTapChargeButton: () {},
            ),
            CustomTitle(title: 'اخر العمليات'),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: 12,
                itemBuilder: (context, index) => WalletOperationListItem(),
                // Add separatorBuilder
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: fix overflow problem when number is big.
class HeaderContainer extends StatelessWidget {
  final String moneyAmount;
  final void Function() onTapChargeButton;
  const HeaderContainer({
    super.key,
    required this.moneyAmount,
    required this.onTapChargeButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      width: Get.width,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.gray,
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  moneyAmount,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 40.sp,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 3, left: 3),
                  child: Text(
                    'ريال',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text('رصيد المحفظة', style: titleSmall),
          SizedBox(height: 15),
          GoHomeButton(
            onTap: onTapChargeButton,
            height: 40,
            width: 100,
            text: 'شحن المحفظة',
          )
        ],
      ),
    );
  }
}
