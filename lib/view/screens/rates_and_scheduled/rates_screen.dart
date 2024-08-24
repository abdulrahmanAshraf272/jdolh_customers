import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/models/user_rate.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class RatesScreen extends StatefulWidget {
  const RatesScreen({super.key});

  @override
  State<RatesScreen> createState() => _RatesScreenState();
}

class _RatesScreenState extends State<RatesScreen> {
  late List<UserRate> rates = [];
  MyServices myServices = Get.find();

  @override
  void initState() {
    rates = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'التقييمات'),
      body: rates.isEmpty
          ? const Center(
              child: Text('لا يوجد تقييمات'),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: rates.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) => UserRateListItem(
                    userRate: rates[index],
                    onTap: () {
                      Get.toNamed(AppRouteName.personProfile,
                          arguments: rates[index].userId);
                    },
                    isThisMe: rates[index].userId ==
                        int.parse(myServices.getUserid()),
                  )),
    );
  }
}

class UserRateListItem extends StatelessWidget {
  final UserRate userRate;
  final void Function() onTap;
  final bool isThisMe;
  const UserRateListItem(
      {super.key,
      required this.userRate,
      required this.onTap,
      required this.isThisMe});

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
              child: Column(
                children: [
                  Row(
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
                                child: userRate.userImage != '' &&
                                        userRate.userImage != null
                                    ? FadeInImage.assetNetwork(
                                        height: 34.w,
                                        width: 34.w,
                                        placeholder:
                                            'assets/images/loading2.gif',
                                        image:
                                            '${ApiLinks.customerImage}/${userRate.userImage}',
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
                                    AutoSizeText('${userRate.userName}',
                                        maxLines: 1,
                                        minFontSize: 11,
                                        overflow: TextOverflow.ellipsis,
                                        style: titleSmall),
                                    Text('${userRate.userUsername}',
                                        style: titleSmallGray)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Rating(
                        rating: userRate.rateRatevalue ?? 0,
                        textColor: Colors.black.withOpacity(0.7),
                      ),
                      const SizedBox(width: 15)
                    ],
                  ),
                  if (userRate.rateComment != '')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                          textAlign: TextAlign.center,
                          '${userRate.rateComment}'),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
