import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/reservation_search_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class DropdownBrandTypes extends StatefulWidget {
  final double? width;
  final double horizontalPadding;
  final double verticalPadding;

  final double buttonHeight;
  const DropdownBrandTypes(
      {super.key,
      this.width,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.buttonHeight = 50});

  @override
  State<DropdownBrandTypes> createState() => _DropdownBrandTypesState();
}

class _DropdownBrandTypesState extends State<DropdownBrandTypes> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationSearchController>(
        builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding,
                  vertical: widget.verticalPadding),
              width: widget.width,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: AutoSizeText(
                    controller.statusRequestType == StatusRequest.loading
                        ? 'برجاء الانتظار ..'
                        : 'حدد نوع المتجر',
                    maxLines: 1,
                    minFontSize: 1,
                    style: titleSmall.copyWith(color: AppColors.gray600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: controller.brandTypesString
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:
                                  titleSmall.copyWith(color: AppColors.gray600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                      controller.setSelectedBrandType(value);
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: widget.buttonHeight,
                    //width: 160,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      //border: Border.all(color: Colors.black26),
                      color: AppColors.gray,
                    ),
                    //elevation: 2,
                  ),
                  iconStyleData: const IconStyleData(
                    icon: ImageIcon(AssetImage('assets/icons/arrow_down2.png')),
                    iconSize: 18,
                    iconEnabledColor: AppColors.gray600,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.gray,
                    ),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ));
  }
}
