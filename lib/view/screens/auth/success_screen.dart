import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/custom_button_one.dart';

class SuccessOperation extends StatelessWidget {
  const SuccessOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            const Center(
                child: Icon(Icons.check_circle_outline,
                    size: 200, color: AppColors.primaryColor)),
            Text('Congratulations!',
                style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 15),
            Text('Operation is Done Successfuly',
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.5))),
            const Spacer(),
            CustomButtonOne(
                textButton: 'Start',
                onPressed: () {
                  //Get.offAllNamed(AppRoute.login);
                })
          ],
        ),
      ),
    );
  }
}
