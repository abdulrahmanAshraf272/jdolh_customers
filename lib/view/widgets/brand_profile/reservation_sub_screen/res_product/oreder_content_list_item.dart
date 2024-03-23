import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class OrderContentCreationListItem extends StatelessWidget {
  final String? image;
  final String name;
  final String desc;
  final String price;
  final int quantity;
  final void Function() onTapDelete;
  final void Function() onTapIncrease;
  final void Function() onTapDecrease;
  const OrderContentCreationListItem({
    super.key,
    required this.image,
    required this.name,
    required this.desc,
    required this.price,
    required this.onTapDelete,
    required this.onTapIncrease,
    required this.onTapDecrease,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray300,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: AppColors.gray400,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image != null
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading2.gif',
                            image: '${ApiLinks.itemsImage}/$image',
                            width: 40.w,
                            height: 38.w,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/noImageAvailable.jpg',
                            width: 40.w,
                            height: 38.w,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AutoSizeText(name,
                            maxLines: 2,
                            minFontSize: 15,
                            overflow: TextOverflow.ellipsis,
                            style: titleSmall),
                        AutoSizeText(desc,
                            maxLines: 2,
                            minFontSize: 6,
                            overflow: TextOverflow.ellipsis,
                            style: titleSmall2.copyWith(color: Colors.grey)),
                        Text('$price ريال',
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(

                //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(onTap: onTapIncrease, text: '+'),
                    Text(
                      '$quantity',
                      style: titleMedium,
                    ),
                    CustomButton(onTap: onTapDecrease, text: '-'),
                    TextButton(
                        onPressed: onTapDelete,
                        child: Text(
                          'ازالة',
                          style:
                              titleSmall.copyWith(color: AppColors.redButton),
                        )),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class ListIsEmptyText extends StatelessWidget {
  const ListIsEmptyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: 'السلة فارغة !\n',
                  style: TextStyle(
                      color: AppColors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                TextSpan(
                    text: 'قم باضافة بعض المنتجات',
                    style: TextStyle(
                        color: AppColors.black.withOpacity(0.4),
                        fontSize: 14,
                        fontFamily: 'Cairo'))
              ])),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
