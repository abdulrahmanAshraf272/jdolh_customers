import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/schedule/reservation_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    //BrandProfileController controller = Get.find();
    return GetBuilder<ReservationDetailsController>(
      builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: ListView.builder(
              itemCount: controller.carts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => OrderContentListItem(
                    image: controller.carts[index].itemsImage,
                    name: controller.carts[index].itemsTitle ?? '',
                    desc: controller.carts[index].cartShortDesc ?? '',
                    price: controller.carts[index].cartTotalPrice.toString(),
                    quantity: controller.carts[index].cartQuantity ?? 0,
                  ))),
    );
  }
}

class OrderContentListItem extends StatelessWidget {
  final String? image;
  final String name;
  final String desc;
  final String price;
  final int quantity;
  const OrderContentListItem({
    super.key,
    this.image,
    required this.name,
    required this.desc,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray400,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              // height: 50.h,
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
                            width: 32.h,
                            height: 32.h,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/noImageAvailable.jpg',
                            height: 32.h,
                            width: 32.h,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(name,
                            maxLines: 2,
                            minFontSize: 15,
                            overflow: TextOverflow.ellipsis,
                            style: titleSmall),
                        AutoSizeText(desc,
                            maxLines: 2,
                            minFontSize: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                              color: AppColors.textDark,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 50.h,
              color: AppColors.gray300,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                '$quantity',
                style: titleMedium,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: 50.h,
              color: AppColors.gray400,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                '$price ريال',
                style: titleSmall.copyWith(fontSize: 13.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderContentTitle extends StatelessWidget {
  const OrderContentTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            height: 50.h,
            color: AppColors.gray450,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text('الصنف', style: titleSmall),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 50.h,
            color: AppColors.gray350,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'العدد',
              style: titleSmall,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            height: 50.h,
            color: AppColors.gray450,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'المبلغ',
              style: titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}
