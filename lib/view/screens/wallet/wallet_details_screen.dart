import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/wallet/wallet_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
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
    Get.put(WalletDetailsController());
    return Scaffold(
        appBar: customAppBar(title: 'المحفظة'.tr),
        body: GetBuilder<WalletDetailsController>(
            builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: SafeArea(
                  child: Column(
                    children: [
                      HeaderContainer(
                        moneyAmount: controller.walletBalance,
                        onTapChargeButton: () =>
                            controller.onTapGoToChargeWallet(),
                        onTapTransferMoney: () =>
                            controller.onTapGoToTransferMoneyToFriend(),
                      ),
                      CustomTitle(title: 'اخر العمليات'.tr),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemCount: controller.walletTransaction.length,
                          itemBuilder: (context, index) =>
                              WalletOperationListItem(
                                  transaction:
                                      controller.walletTransaction[index]),
                          // Add separatorBuilder
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}

class HeaderContainer extends StatelessWidget {
  final String moneyAmount;
  final void Function() onTapChargeButton;
  final void Function() onTapTransferMoney;
  const HeaderContainer({
    super.key,
    required this.moneyAmount,
    required this.onTapChargeButton,
    required this.onTapTransferMoney,
  });

  @override
  Widget build(BuildContext context) {
    List<String> parts = moneyAmount.split('.');

    String integerPart = parts[0];
    String fractionPart = parts.length > 1
        ? parts[1]
        : '00'; // Default to '00' if there's no fractional part
    return Container(
      // height: Get.height * 0.3,
      width: Get.width,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AutoSizeText(
                      '$fractionPart.',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Flexible(
                  child: AutoSizeText(
                    integerPart,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 40.sp,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 3, left: 3),
                  child: Text(
                    'ريال'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text('رصيد المحفظة'.tr, style: titleSmall),
          const SizedBox(height: 15),
          GoHomeButton(
            onTap: onTapChargeButton,
            height: 40,
            width: 100.w,
            text: 'شحن المحفظة'.tr,
          ),
          const SizedBox(height: 5),
          TextButton(
              onPressed: onTapTransferMoney, child: Text('تحويل رصيد'.tr))
        ],
      ),
    );
  }
}
