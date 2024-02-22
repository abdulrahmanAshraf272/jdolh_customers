import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/checkin/add_new_place_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class AddNewPlaceScreen extends StatelessWidget {
  const AddNewPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddNewPlaceController());
    return GetBuilder<AddNewPlaceController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'إضافة مكان'),
              floatingActionButton: BottomButton(
                onTap: () => controller.onTapConfirm(),
                text: 'تأكيد',
                buttonColor: AppColors.secondaryColor,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(
                        title: 'اسم المكان', bottomPadding: 10),
                    CustomTextField(
                        textEditingController: controller.placeName,
                        hintText: 'اضف اسم المكان'),
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'عنوان المكان'),
                    DateOrLocationDisplayContainer(
                        hintText: controller.placeLocation == ''
                            ? 'حدد موقع المكان'
                            : controller.placeLocation,
                        iconData: Icons.place,
                        onTap: () {
                          controller.goToAddLocation();
                        }),
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'نوع المكان'),
                    CustomDropdownButton()
                  ],
                ),
              ),
            ));
  }
}

class CustomDropdownButton extends StatefulWidget {
  final double? width;
  final double horizontalPadding;
  final double verticalPadding;

  final double buttonHeight;
  const CustomDropdownButton(
      {super.key,
      this.width,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.buttonHeight = 50});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedValue;

  final List<String> items = [
    '---',
    'مطعم',
    'كافيه',
    'مكان عام',
    'ملاهي',
    'جيم',
    'مكان سياحي',
    'سوبر ماركت',
    'مول',
    'محل ملابس',
    'اخر'
  ];

  @override
  void initState() {
    // TODO: implement initState
    selectedValue = items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddNewPlaceController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
      width: widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Icon(
                Icons.restaurant,
                size: 16,
                color: AppColors.gray600,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: AutoSizeText(
                  'حدد نوع المكان',
                  maxLines: 1,
                  minFontSize: 1,
                  style: titleSmall.copyWith(color: AppColors.gray600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: titleSmall.copyWith(color: AppColors.gray600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
              controller.placeType = selectedValue!;
              print(controller.placeType);
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
    );
  }
}
