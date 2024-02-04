import 'package:flutter/material.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/content_list_item.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/extra_fee_list_item.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/title.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price_with_fee.dart';

class OrderContent extends StatelessWidget {
  const OrderContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OrderContentTitle(),
      OrderContentListItem(),
      OrderTotalPrice(),
      SizedBox(height: 10),
      OrderExtraFeeListItem(),
      OrderTotalPriceWithFees()
    ]);
  }
}
