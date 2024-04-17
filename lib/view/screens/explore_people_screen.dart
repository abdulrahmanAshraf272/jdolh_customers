import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ExplorePeopleScreen extends StatefulWidget {
  const ExplorePeopleScreen({super.key});

  @override
  State<ExplorePeopleScreen> createState() => _ExplorePeopleScreenState();
}

class _ExplorePeopleScreenState extends State<ExplorePeopleScreen> {
  List<Friend> users = [];
  gotoPersonProfile(int index) {
    Get.toNamed(AppRouteName.personProfile, arguments: users[index]);
  }

  @override
  void initState() {
    if (Get.arguments != null) {
      users = List.from(Get.arguments);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'الأكثر تقييم خلال اسبوع',
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: users.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                ),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ExplorePeopleListItem(
                    user: users[index],
                    onTap: () => gotoPersonProfile(index),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class ExplorePeopleListItem extends StatelessWidget {
  final void Function() onTap;
  final Friend user;
  const ExplorePeopleListItem({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width / 2 - 30,
        height: Get.width / 2 - 30,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.gray),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: user.userImage != '' && user.userImage != null
                  ? FadeInImage.assetNetwork(
                      height: Get.width * 0.16,
                      width: Get.width * 0.16,
                      placeholder: 'assets/images/loading2.gif',
                      image: '${ApiLinks.customerImage}/${user.userImage}',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/person4.jpg',
                      fit: BoxFit.cover,
                      height: Get.width * 0.16,
                      width: Get.width * 0.16,
                    ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  AutoSizeText(
                    user.userName ?? '',
                    maxLines: 1,
                    style: titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Expanded(
                    child: AutoSizeText(
                      user.userUsername ?? '',
                      maxLines: 1,
                      style: titleSmall2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  AutoSizeText(
                    'قام ب${user.count} تقييم جديد',
                    maxLines: 1,
                    style: titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
