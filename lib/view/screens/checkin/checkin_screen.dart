import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/checkin/checkin_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/find_checkincard_icon.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class CheckinScreen extends StatelessWidget {
  const CheckinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckinController());
    return GetBuilder<CheckinController>(builder: (controller) {
      return Scaffold(
          appBar: customAppBar(title: 'تسجيل الوصول'.tr),
          body: Center(
            child: SingleChildScrollView(
              child: HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: controller.latLng != null
                      ? Column(
                          children: [
                            ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                shrinkWrap: true,
                                itemCount: controller.allPlaces.length,
                                itemBuilder: (context, index) => PlacesListItem(
                                    name:
                                        controller.allPlaces[index].name ?? '',
                                    location:
                                        controller.allPlaces[index].location ??
                                            '',
                                    type:
                                        controller.allPlaces[index].type ?? '',
                                    onTapCard: () {
                                      controller.onTapCard(
                                          controller.allPlaces[index]);
                                    })
                                // Add separatorBuilder
                                ),
                            GoHomeButton(
                              onTap: () => controller.goToAddNewPlace(),
                              text: 'اضافة مكان'.tr,
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                      : const SizedBox()),
            ),
          ));
    });
  }
}

class PlacesListItem extends StatelessWidget {
  final String name;
  final String location;
  final String type;
  final void Function() onTapCard;

  const PlacesListItem({
    super.key,
    required this.name,
    required this.location,
    required this.type,
    required this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapCard,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(5),
                          //   child: Image.asset(
                          //     'assets/images/avatar_person.jpg',
                          //     height: 34.w,
                          //     width: 34.w,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          Icon(
                            findSuitableIconForCard(type),
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(name,
                                    maxLines: 1,
                                    minFontSize: 11,
                                    overflow: TextOverflow.ellipsis,
                                    style: titleSmall),
                                AutoSizeText(location,
                                    maxLines: 1,
                                    minFontSize: 11,
                                    overflow: TextOverflow.ellipsis,
                                    style: titleSmallGray)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
