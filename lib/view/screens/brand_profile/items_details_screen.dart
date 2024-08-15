import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/items_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/data/models/ioption_element.dart';
import 'package:jdolh_customers/data/models/item_option.dart';
import 'package:jdolh_customers/view/widgets/product_features/price_and_confirm_button.dart';
import 'package:jdolh_customers/view/widgets/product_features/product_image_and_name.dart';

class ItemsDetailsScreen extends StatelessWidget {
  const ItemsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsDetailsController());
    return GetBuilder<ItemsDetailsController>(
        builder: (controller) => Scaffold(
              floatingActionButton:
                  controller.statusRequest != StatusRequest.loading
                      ? PriceAndConfirmReservationButton(
                          onTap: () {
                            controller.onTapAddToCart();
                          },
                          price: controller.totalPrice.toString(),
                        )
                      : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: Column(
                children: [
                  ProductImageAndName(
                    image: controller.item.itemsImage,
                    name: controller.item.itemsTitle ?? '',
                    itemPrice: controller.itemPrice.toString(),
                    itemPriceAfterDiscount:
                        controller.itemPriceAfterDiscount.toString(),
                  ),
                  const SizedBox(height: 20),
                  Text(controller.item.itemsDesc ?? ''),
                  const SizedBox(height: 10),
                  if (controller.brand.brandIsService == 0)
                    QuantitySetter(
                        quantity: controller.quantity,
                        onTapIncrease: controller.onTapIncrease,
                        onTapDecrease: controller.onTapDecrease),
                  HandlingDataRequest(
                      statusRequest: controller.statusRequest,
                      widget: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.itemOptions.length,
                          itemBuilder: (context, index) => ItemOptionWidget(
                                itemOption: controller.itemOptions[index],
                              )))
                ],
              ),
            ));
  }
}

class QuantitySetter extends StatelessWidget {
  final int quantity;
  final void Function() onTapIncrease;
  final void Function() onTapDecrease;
  const QuantitySetter({
    super.key,
    required this.quantity,
    required this.onTapIncrease,
    required this.onTapDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      //padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 20,
            icon: const Icon(Icons.add),
            onPressed: onTapIncrease,
          ),
          Text(
            '$quantity',
            style: const TextStyle(fontSize: 14.0),
          ),
          IconButton(
            iconSize: 20,
            icon: const Icon(Icons.remove),
            onPressed: onTapDecrease,
          ),
        ],
      ),
    );
  }
}

class ItemOptionWidget extends StatefulWidget {
  final ItemOption itemOption;
  const ItemOptionWidget({super.key, required this.itemOption});

  @override
  State<ItemOptionWidget> createState() => _ItemOptionWidgetState();
}

class _ItemOptionWidgetState extends State<ItemOptionWidget> {
  List<IOptionElement>? get elements => widget.itemOption.elements;
  bool get isMultiselect => widget.itemOption.isMultiselect == 1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemsDetailsController());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: AppColors.gray),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  widget.itemOption.title ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              IsBasicText(isBasic: widget.itemOption.isBasic ?? 0)
            ],
          ),
          const SizedBox(height: 5),
          if (widget.itemOption.isMultiselect == 0)
            Text(
              'اختر 1'.tr,
              style: const TextStyle(fontSize: 12),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: elements!.map((element) {
              return Row(
                children: [
                  Expanded(
                      child: AutoSizeText(element.name ?? "", maxLines: 1)),
                  if (element.price != 0)
                    widget.itemOption.priceDep == 1
                        ? Text('${element.price} ريال')
                        : Text('+ ${element.price} ريال'),
                  Checkbox(
                    activeColor: AppColors.primaryColor,
                    value: controller.elementSelected.contains(element),
                    onChanged: isMultiselect
                        ? (checked) {
                            setState(() {
                              if (checked!) {
                                controller.elementSelected.add(element);
                              } else {
                                controller.elementSelected.remove(element);
                              }

                              controller.updateTotalPrice();
                            });
                          }
                        : (checked) {
                            setState(() {
                              if (checked!) {
                                controller.clearItemOptionElements(element);
                                controller.elementSelected.add(element);
                              } else {
                                controller.clearItemOptionElements(element);
                              }

                              controller.updateTotalPrice();
                            });
                          },
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class IsBasicText extends StatelessWidget {
  final int isBasic;
  const IsBasicText({super.key, required this.isBasic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: isBasic == 1
              ? AppColors.secondaryColor300
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30)),
      child: isBasic == 1
          ? Text(
              'مطلوب'.tr,
              style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            )
          : Text(
              'اختياري'.tr,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
    );
  }
}


// class ItemOptionWidget extends StatefulWidget {
//   final ItemOption itemOption;

//   const ItemOptionWidget({
//     super.key,
//     required this.itemOption,
//   });

//   @override
//   _ItemOptionWidgetState createState() => _ItemOptionWidgetState();
// }

// class _ItemOptionWidgetState extends State<ItemOptionWidget> {
//   List<IOptionElement>? get elements => widget.itemOption.elements;
//   bool get isMultiselect => widget.itemOption.isMultiselect == 1;

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ItemsDetailsController());
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15), color: AppColors.gray),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.itemOption.title ?? "",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: elements!.map((element) {
//               return CheckboxListTile(
//                 title: Text(element.name ?? ""),
//                 value: controller.elementSelected.contains(element.name),
//                 onChanged: isMultiselect
//                     ? (checked) {
//                         setState(() {
//                           if (checked!) {
//                             controller.elementSelected.add(element.name!);
//                             controller.totalPrice += element.price ?? 0;
//                             print(controller.elementSelected);
//                             print(controller.totalPrice);
//                           } else {
//                             controller.elementSelected.remove(element.name);
//                             controller.totalPrice -= element.price ?? 0;
//                             print(controller.elementSelected);
//                             print(controller.totalPrice);
//                           }
//                         });
//                       }
//                     : (checked) {
//                         setState(() {
//                           if (checked!) {
//                             controller.clearItemOption(elements!);
//                             controller.elementSelected.add(element.name!);
//                             controller.totalPrice += element.price ?? 0;
//                             print(controller.elementSelected);
//                             print(controller.totalPrice);
//                           } else {
//                             controller.clearItemOption(elements!);
//                             print(controller.elementSelected);
//                             print(controller.totalPrice);
//                           }
//                         });
//                       },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
