import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ExplorePeopleScreen extends StatelessWidget {
  const ExplorePeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'الأكثر زيارة خلال اسبوع',
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: 7,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                ),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ExplorePeopleListItem();
                }),
          ),
        ],
      ),
    );
  }
}

class ExplorePeopleListItem extends StatelessWidget {
  const ExplorePeopleListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2 - 30,
      height: Get.width / 2 - 30,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.gray),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              'assets/images/avatar_person.jpg',
              height: Get.width * 0.15,
              width: Get.width * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                AutoSizeText(
                  'خالد',
                  maxLines: 1,
                  style: titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Expanded(
                  child: AutoSizeText(
                    '@khalid323',
                    maxLines: 1,
                    style: titleSmall2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                AutoSizeText(
                  'قام ب35 تقييم جديد',
                  maxLines: 1,
                  style: titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
