import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/trend.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/top_checkin.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ExploreCheckinScreen extends StatefulWidget {
  const ExploreCheckinScreen({super.key});

  @override
  State<ExploreCheckinScreen> createState() => _ExploreCheckinScreenState();
}

class _ExploreCheckinScreenState extends State<ExploreCheckinScreen> {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  List<TopCheckin> topCheckin = [];
  TrendData trendData = TrendData(Get.find());
  late String myId;

  List<Friend> checkPeople = [];

  gotoDisplayCheckinPeople(int placeid) {
    print('placeid: $placeid');
    getCheckinPeople(placeid).then((value) => {
          if (value is List<Friend>)
            {
              Get.to(() => FollowersAndFollowingScreen(
                  title: 'المتواجدين حالياً', data: value))
            }
          else
            {CustomDialogs.failure()}
        });
  }

  Future getCheckinPeople(int placeid) async {
    CustomDialogs.loading();
    var response =
        await trendData.getTopCheckinPeople(placeid.toString(), myId);
    await Future.delayed(const Duration(seconds: lateDuration));
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        print(data);
        List<Friend> checkPeople = data.map((e) => Friend.fromJson(e)).toList();
        //checkPeople.removeWhere((element) => element.userId.toString() == myId);
        return checkPeople;
      } else {
        print('failure');
      }
    }
  }

  @override
  void initState() {
    myId = myServices.getUserid();
    if (Get.arguments != null) {
      topCheckin = List.from(Get.arguments);
      topCheckin.forEach((element) {
        print(element.placeId);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'الأكثر تسجيل وصول خلال ساعتين',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                physics: BouncingScrollPhysics(),
                itemCount: topCheckin.length,
                itemBuilder: (context, index) => ExploreCheckinListItem(
                    onTap: () =>
                        gotoDisplayCheckinPeople(topCheckin[index].placeId!),
                    name: topCheckin[index].placeName ?? '',
                    count: topCheckin[index].checkinCount ?? 0)),
          ),
        ],
      ),
    );
  }
}

class ExploreCheckinListItem extends StatelessWidget {
  final String name;
  final int count;
  final void Function() onTap;
  const ExploreCheckinListItem(
      {super.key,
      required this.name,
      required this.count,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        // width: Get.width / 2 - 30,
        // height: Get.width / 2 - 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 4,
                color: Colors.black45.withOpacity(0.23),
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: AppColors.gray,
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.location_city,
                      color: Colors.grey,
                      size: 30.w,
                    ),
                  )),
              const SizedBox(width: 10),
              Expanded(
                child: AutoSizeText(
                  name,
                  maxLines: 2,
                  style: titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Text(
                    '$count',
                    style: titleSmall,
                  ),
                  const Icon(Icons.person)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
