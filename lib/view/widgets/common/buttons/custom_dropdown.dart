import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CustomDropdown extends StatefulWidget {
  final double? width;
  final double horizontalPadding;
  final double verticalPadding;
  final double buttonHeight;
  final double displacement;
  final String title;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double listWidth;
  final double horizontalMargin;
  final double verticalMargin;
  final bool withInitValue;

  const CustomDropdown(
      {super.key,
      this.width,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.buttonHeight = 50,
      this.displacement = -20,
      this.listWidth = 200,
      this.horizontalMargin = 20,
      this.verticalMargin = 0,
      this.withInitValue = false,
      required this.items,
      required this.onChanged,
      required this.title});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    if (widget.withInitValue == true) {
      selectedValue = widget.items[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: widget.horizontalMargin, vertical: widget.verticalMargin),
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
      width: widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: AutoSizeText(
            widget.title,
            maxLines: 1,
            minFontSize: 1,
            style: titleSmall.copyWith(color: AppColors.gray600),
            overflow: TextOverflow.ellipsis,
          ),
          items: widget.items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: AutoSizeText(
                      item,
                      minFontSize: 9,
                      maxLines: 1,
                      style: titleSmall.copyWith(color: AppColors.gray600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
              widget.onChanged(value);
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
            width: widget.listWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.gray,
            ),
            offset: Offset(widget.displacement, 0),
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
    );
  }
}
