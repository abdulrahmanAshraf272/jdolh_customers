import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/auth/edit_personal_data_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/valid_input.dart';
import 'package:jdolh_customers/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_customers/view/widgets/common/avatar_image_holder.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_dropdown.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class EdtiPersonalDataScreen extends StatelessWidget {
  const EdtiPersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dataSavedSuccessfuly() {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'تم حفظ البيانات',
        btnOkText: 'حسنا',
        btnOkOnPress: () {
          Get.offAllNamed(AppRouteName.mainScreen, arguments: {"page": 3});
        },
      ).show();
    }

    Get.put(EditPersonalDataController());
    return Scaffold(
      appBar: customAppBar(title: 'البيانات الشخصية'),
      body: GetBuilder<EditPersonalDataController>(
          builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Form(
                    key: controller.formstate,
                    child: HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                AvatarImageHolder(
                                  onTap: () => controller.uploadImage(),
                                  selectedImage: controller.selectedImage,
                                  imageFromNetwork: controller.networkImage ==
                                          ''
                                      ? ''
                                      : '${ApiLinks.customerImage}/${controller.networkImage}',
                                ),
                                CustomTextFormAuthTwo(
                                  labelText: 'الاسم الاول',
                                  valid: (val) => firstNameValidInput(val!),
                                  iconData: Icons.person,
                                  textEditingController: controller.firstName,
                                ),
                                CustomTextFormAuthTwo(
                                  labelText: 'اسم العائلة',
                                  valid: (val) => firstNameValidInput(val!),
                                  iconData: Icons.person,
                                  textEditingController: controller.lastName,
                                ),
                                CustomTextFormAuthTwo(
                                  labelText: 'اسم المستخدم',
                                  valid: (val) =>
                                      validInput(val!, 2, 50, 'username'),
                                  iconData: Icons.person,
                                  textEditingController: controller.username,
                                ),
                                CustomTextFormAuthTwo(
                                  labelText: 'البريد الإلكتروني',
                                  keyboardType: TextInputType.emailAddress,
                                  valid: (val) {
                                    return validInput(val!, 5, 100, 'email');
                                  },
                                  iconData: Icons.email_outlined,
                                  textEditingController: controller.email,
                                ),
                                TextFieldPhoneNumber(
                                  textEditingController: controller.phoneNumber,
                                  onChanged: (phone) {
                                    controller.countryKey = phone.countryCode;
                                  },
                                ),
                                const SizedBox(height: 20),
                                GenderSelection(
                                  onTapMale: () {
                                    controller.gender = 1;
                                  },
                                  onTapFamale: () {
                                    controller.gender = 2;
                                  },
                                  initialValue: controller.gender,
                                ),
                                const CustomSmallTitle(
                                    title: 'المدينة', rightPdding: 0),
                                CustomDropdown(
                                  items: cities,
                                  horizontalMargin: 0,
                                  verticalMargin: 10,
                                  //withInitValue: true,
                                  //width: Get.width / 2.2,
                                  title: controller.city,
                                  onChanged: (String? value) {
                                    // Handle selected value
                                    controller.city = value!;

                                    print(value);
                                  },
                                ),
                                const SizedBox(height: 20),
                                CustomButtonOne(
                                    textButton: 'حفظ',
                                    onPressed: () {
                                      controller.editPersonalData();
                                    }),
                              ]),
                        ),
                      ),
                    )),
              )),
    );
  }
}

class GenderSelection extends StatefulWidget {
  final Function() onTapMale;
  final Function() onTapFamale;
  final int initialValue;

  const GenderSelection(
      {super.key,
      required this.onTapFamale,
      required this.onTapMale,
      this.initialValue = 1});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  int selectedOption = 1;
  Color firstColor = AppColors.secondaryColor;
  Color secondColor = AppColors.gray400;

  @override
  void initState() {
    print(widget.initialValue);
    selectedOption = widget.initialValue;
    print(selectedOption);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: AppColors.gray),
      //width: 80.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              widget.onTapMale();
              setState(() {
                selectedOption = 1;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: selectedOption == 1 ? firstColor : null,
              ),
              alignment: Alignment.center,
              child: Text(
                'ذكر',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  color: selectedOption == 1
                      ? AppColors.white
                      : AppColors.grayText,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.onTapFamale();
              setState(() {
                selectedOption = 2;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: selectedOption == 2 ? firstColor : null,
              ),
              child: Text(
                'انثى',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  color: selectedOption == 2
                      ? AppColors.white
                      : AppColors.grayText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
