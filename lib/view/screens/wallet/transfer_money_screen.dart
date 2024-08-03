import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/wallet/transfer_money_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/view/screens/wallet/wallet_charging_screen.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class TranferMoneyScreen extends StatelessWidget {
  const TranferMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TransferMoneyController());
    return Scaffold(
      appBar: customAppBar(title: 'تحويل رصيد'.tr),
      body: GetBuilder<TransferMoneyController>(
        builder: (controller) => SizedBox(
            width: Get.width,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text('المبلغ'.tr,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  MonoyDepositeTextField(
                    textEditingController: controller.amount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك ادخل المبلغ'.tr;
                      }

                      // Check for leading zeros
                      if (value.startsWith('0') &&
                          value.length > 1 &&
                          !value.startsWith('0.')) {
                        return 'رقم غير صالح'.tr;
                      }

                      // Check for valid decimal format
                      if (value.contains(',')) {
                        return 'رقم غير صالح'.tr;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text('ريال'.tr),
                  const SizedBox(height: 20),
                  SelectUser(
                      onTapAdd: () => controller.onTapAddMembers(),
                      user: controller.selectedUser),
                  const Spacer(),
                  BottomButton(
                      onTap: () => controller.onTapTransferMoney(context),
                      text: 'تحويل'.tr)
                ],
              ),
            )),
      ),
    );
  }
}

class SelectUser extends StatelessWidget {
  final Function() onTapAdd;
  final Friend? user;
  const SelectUser({super.key, required this.onTapAdd, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (user != null)
          UserListItem(
              name: user!.userName ?? '',
              userName: user!.userUsername ?? '',
              image: user!.userImage,
              onTapCard: () {},
              id: user!.userId ?? 0),
        const SizedBox(height: 10),
        CustomButton(
          onTap: onTapAdd,
          text: user == null ? 'اختر المستخدم'.tr : 'تغيير المستخدم'.tr,
          size: 1.2,
        )
      ],
    );
  }
}

class UserListItem extends StatelessWidget {
  final int id;
  final String name;
  final String userName;
  final String? image;
  final Function()? onTapCard;

  const UserListItem(
      {super.key,
      required this.name,
      required this.userName,
      required this.image,
      required this.onTapCard,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapCard,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text('$id', style: titleSmallGray),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image != '' && image != null
                        ? FadeInImage.assetNetwork(
                            height: 34.w,
                            width: 34.w,
                            placeholder: 'assets/images/loading2.gif',
                            image: '${ApiLinks.customerImage}/$image',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/person4.jpg',
                            fit: BoxFit.cover,
                            height: 34.w,
                            width: 34.w,
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(name,
                            maxLines: 1,
                            minFontSize: 11,
                            overflow: TextOverflow.ellipsis,
                            style: titleSmall),
                        Text(userName, style: titleSmallGray)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
