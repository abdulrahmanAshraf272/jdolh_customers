import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/brand_search.dart';
import 'package:jdolh_customers/data/models/user.dart';
import 'package:jdolh_customers/view/screens/rates_and_scheduled/scheduled_users_screen.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class BchFollowersScreen extends StatefulWidget {
  const BchFollowersScreen({super.key});

  @override
  State<BchFollowersScreen> createState() => _BchFollowersScreenState();
}

class _BchFollowersScreenState extends State<BchFollowersScreen> {
  StatusRequest statusRequest = StatusRequest.none;
  BrandSearchData brandSearchData = BrandSearchData(Get.find());

  late List<User> bchFollowers = [];
  MyServices myServices = Get.find();
  getBchFollowers(int bchId) async {
    statusRequest = StatusRequest.loading;
    setState(() {});

    var response =
        await brandSearchData.getBchFollowers(bchId: bchId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        bchFollowers = data.map((element) => User.fromJson(element)).toList();
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    int bchId = Get.arguments;
    getBchFollowers(bchId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'المتابعين'),
      body: HandlingDataView(
        statusRequest: statusRequest,
        widget: bchFollowers.isEmpty
            ? const Center(
                child: Text('لا يوجد متابعين'),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: bchFollowers.length,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) => ScheduledUserListItem(
                    user: bchFollowers[index],
                    onTap: () {
                      Get.toNamed(AppRouteName.personProfile,
                          arguments: bchFollowers[index].userId);
                    },
                    isThisMe: bchFollowers[index].userId ==
                        int.parse(myServices.getUserid()))),
      ),
    );
  }
}
