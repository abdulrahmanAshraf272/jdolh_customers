import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/models/user.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_name_image.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ScheduledUsersScreen extends StatefulWidget {
  const ScheduledUsersScreen({super.key});

  @override
  State<ScheduledUsersScreen> createState() => _ScheduledUsersScreenState();
}

class _ScheduledUsersScreenState extends State<ScheduledUsersScreen> {
  late List<User> scheduledUsers = [];
  MyServices myServices = Get.find();
  @override
  void initState() {
    scheduledUsers = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'المجدولين'),
      body: scheduledUsers.isEmpty
          ? const Center(
              child: Text('لا يوجد مجدولين'),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: scheduledUsers.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) => ScheduledUserListItem(
                  user: scheduledUsers[index],
                  onTap: () {
                    Get.toNamed(AppRouteName.personProfile,
                        arguments: scheduledUsers[index].userId);
                  },
                  isThisMe: scheduledUsers[index].userId ==
                      int.parse(myServices.getUserid()))),
    );
  }
}

class ScheduledUserListItem extends StatelessWidget {
  final User user;
  final void Function() onTap;
  final bool isThisMe;
  const ScheduledUserListItem({
    super.key,
    required this.user,
    required this.onTap,
    required this.isThisMe,
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
            onTap: isThisMe ? null : onTap,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: user.image != '' && user.image != null
                                ? FadeInImage.assetNetwork(
                                    height: 34.w,
                                    width: 34.w,
                                    placeholder: 'assets/images/loading2.gif',
                                    image:
                                        '${ApiLinks.customerImage}/${user.image}',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/person4.jpg',
                                    fit: BoxFit.cover,
                                    height: 34.w,
                                    width: 34.w,
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(user.userName ?? '',
                                    maxLines: 1,
                                    minFontSize: 11,
                                    overflow: TextOverflow.ellipsis,
                                    style: titleSmall),
                                Text(user.userUsername ?? '',
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
