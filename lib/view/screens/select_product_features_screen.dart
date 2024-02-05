import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/product_features/price_and_confirm_button.dart';
import 'package:jdolh_customers/view/widgets/product_features/product_image_and_name.dart';
import 'package:jdolh_customers/view/widgets/product_features/select_product_size.dart';

class SelectProductFeaturesScreen extends StatelessWidget {
  const SelectProductFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'title'),
      floatingActionButton: PriceAndConfirmReservationButton(
        onTap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          ProductImageAndName(),
          CustomTitle(
            title: 'الحجم',
            customTextStyle: titleLargeNotBold,
            topPadding: 20,
            bottomPadding: 10,
          ),
          SelectSize(),
        ],
      ),
    );
  }
}
