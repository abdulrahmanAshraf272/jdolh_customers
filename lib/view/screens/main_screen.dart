import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/alert_exit_app.dart';
import 'package:jdolh_customers/view/widgets/custom_bottom_appbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => alertExitAppNew(),
      child: GetBuilder<MainController>(
          builder: (controller) => Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(AppRouteName.checkin);
                  },
                  backgroundColor: AppColors.secondaryColor,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.place,
                    color: Colors.white,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: const CustomBottomAppBar(),
                body: controller.listPage.elementAt(controller.currentPage),
              )),
    );
  }
}
