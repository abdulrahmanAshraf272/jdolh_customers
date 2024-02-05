import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ExploreBrandScreen extends StatelessWidget {
  const ExploreBrandScreen({super.key});

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
                  childAspectRatio: 1.35,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                ),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ExploreBrandListItem();
                }),
          ),
        ],
      ),
    );
  }
}

class ExploreBrandListItem extends StatelessWidget {
  const ExploreBrandListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2 - 30,
      //height: Get.width / 2 - 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 4,
            color: Colors.black45.withOpacity(0.23))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/breakfastDishe24.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: AppColors.gray,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      'بيتزا هت',
                      maxLines: 1,
                      style: titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Row(
                    children: [
                      Text(
                        '300',
                        style: titleSmall,
                      ),
                      Icon(Icons.person)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
