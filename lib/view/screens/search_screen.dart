import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/search_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchScreenController());
    return Scaffold(
      body: GetBuilder<SearchScreenController>(
        builder: (controller) => Column(
          children: [
            SearchAppBar(
              onTapSearch: () {
                controller.seachOnTap();
              },
            ),
            LargeToggleButtons(
                optionOne: 'اشخاص',
                optionTwo: 'اماكن',
                onTapOne: () => controller.activePersonSearch(),
                onTapTwo: () => controller.inactivePersonSearch()),
            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 30, top: 10),
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) => PersonWithButtonListItem(
                    name: controller.data[index].userName!,
                    userName: controller.data[index].userUsername!,
                    image: controller.data[index].userImage!,
                    buttonText: controller.data[index].following!
                        ? 'الغاء المتابعة'
                        : 'متابعة',
                    buttonColor: controller.data[index].following!
                        ? AppColors.redButton
                        : AppColors.secondaryColor,
                    onTap: () {},
                  ),
                  // Add separatorBuilder
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchAppBar extends StatelessWidget {
  final void Function() onTapSearch;
  const SearchAppBar({
    super.key,
    required this.onTapSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            TextButton(
                onPressed: onTapSearch,
                child: Text(
                  'بحث',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                )),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                  color: AppColors.white,
                ),
                child: GetBuilder<SearchScreenController>(
                  builder: (controller) => TextFormField(
                    controller: controller.name,
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'اكتب اسم الشخص',
                      hintStyle: const TextStyle(fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
