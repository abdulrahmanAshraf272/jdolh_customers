import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/occasion/add_to_occasion_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class AddToOccasionScreen extends StatelessWidget {
  const AddToOccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddToOccasionController());
    return Scaffold(
        appBar: customAppBar(title: 'أضف للمجموعة'),
        floatingActionButton: GoHomeButton(
          onTap: () {
            controller.saveChanges();
          },
          text: 'حفظ',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: GetBuilder<AddToOccasionController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: controller.searchController,
                hintText: 'البحث في قائمة الأصدقاء',
                iconData: Icons.search,
                onChange: (value) => controller.updateList(value),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 30, top: 20),
                  itemCount: controller.myfollowingFiltered.length,
                  itemBuilder: (context, index) => PersonWithButtonListItem(
                    name: controller.myfollowingFiltered[index].userName!,
                    userName:
                        controller.myfollowingFiltered[index].userUsername!,
                    image: controller.myfollowingFiltered[index].userImage!,
                    onTap: () {
                      controller.addRemoveMember(index);
                    },
                    onTapCard: () {},
                    buttonText: controller.getTextButton(index),
                    buttonColor: controller.getTextColor(index),
                  ),
                  // Add separatorBuilder
                ),
              ),
            ],
          ),
        ));
  }
}

// class AddGroupIconListItem extends StatelessWidget {
//   const AddGroupIconListItem({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         children: [
//           Container(
//             height: 50,
//             width: 50,
//             child: Stack(
//               children: [
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   child: Container(
//                     height: 45,
//                     width: 45,
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Icon(
//                       Icons.groups,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     child: Container(
//                   width: 20,
//                   height: 20,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: AppColors.secondaryColor, shape: BoxShape.circle),
//                   child: AutoSizeText(
//                     '+',
//                     maxLines: 1,
//                     style: titleSmallGray.copyWith(color: Colors.white),
//                   ),
//                 )),
//               ],
//             ),
//           ),
//           SizedBox(height: 3),
//           Text(
//             'قروب الاستراحة',
//             style: titleSmall,
//           )
//         ],
//       ),
//     );
//   }
// }
