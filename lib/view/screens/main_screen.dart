import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/widgets/custom_bottom_appbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> items = List.generate(20, (index) => 'Item $index');
  Future<void> _refreshData() async {
    // Simulate fetching new data
    await Future.delayed(Duration(seconds: 2));

    // Update the UI with the new data
    setState(() {
      items = List.generate(20, (index) => 'New Item $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetBuilder<MainController>(
        builder: (controller) => RefreshIndicator(
              onRefresh: () => controller.getMyProfileData(),
              child: Scaffold(
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     Get.toNamed(AppRouteName.reservation);
                //   },
                //   backgroundColor: AppColors.secondaryColor,
                //   shape: const CircleBorder(),
                //   child: const Icon(Icons.list),
                // ),
                // floatingActionButtonLocation:
                //     FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: const CustomBottomAppBar(),
                body: controller.listPage.elementAt(controller.currentPage),
              ),
            ));
  }
}
