// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
// import 'package:jdolh_customers/core/constants/app_colors.dart';
// import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/invintors.dart';
// import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/order_content_creation.dart';
// import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/reservation_options_extraSeats.dart';
// import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/extra_fee_list_item.dart';
// import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price.dart';
// import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price_with_fee.dart';
// import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
// import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_button_one_option.dart';
// import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
// import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

// class ReservationSubScreen extends StatelessWidget {
//   const ReservationSubScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(BrandProfileController());
//     print('reservation screen rebuild');
//     return Column(
//       children: [
//         ReservationOptionsAndExtraSeats(),
//         CustomSmallTitle(
//           title: 'وقت الحجز',
//           topPadding: 20,
//         ),
//         DateOrLocationDisplayContainer(
//           hintText: 'اختر وقت الحجز',
//           iconData: Icons.date_range_outlined,
//           onTap: () {},
//         ),
//         CustomToggleButtonsOneOption(
//           firstOption: 'ارسال دعوة',
//           onTapOne: () => controller.activeWithInvitationOption(),
//           secondOption: 'بدون دعوة',
//           onTapTwo: () => controller.activeNoInvitationOption(),
//           horizontalPadding: 20,
//           verticalPadding: 10,
//         ),
//         controller.withInvitation ? Invitors() : const SizedBox(),
//         CustomSmallTitle(
//           title: 'تفاصيل الطلب',
//           topPadding: 20,
//           bottomPadding: 10,
//         ),
//         ListView.builder(
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             padding: EdgeInsets.symmetric(vertical: 0),
//             itemCount: 3,
//             itemBuilder: (context, index) => OrderContentCreationListItem()),
//         OrderTotalPrice(),
//         SizedBox(height: 10),
//         ListView.builder(
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             padding: EdgeInsets.symmetric(vertical: 0),
//             itemCount: 3,
//             itemBuilder: (context, index) => OrderExtraFeeListItem()),
//         OrderTotalPriceWithFees(),
//         SizedBox(height: 20),
//         controller.timerIsActive
//             ? Obx(
//                 () => Text(
//                   textAlign: TextAlign.center,
//                   'الوقت المتبقي:${controller.remainingMin.value} دقيقة : ${controller.remainingSec.value} ثانية',
//                   style:
//                       const TextStyle(fontSize: 18, color: AppColors.redText),
//                 ),
//               )
//             : const SizedBox(),
//         const SizedBox(height: 80),
//         BottomButton(
//             onTap: () {
              
//             },
//             text: ''),
//       ],
//     );
//   }
// }
