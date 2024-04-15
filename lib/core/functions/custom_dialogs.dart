import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

abstract class CustomDialogs {
  static success([String title = 'تم']) {
    EasyLoading.instance
      ..backgroundColor = Colors.green // Or your desired background color
      ..indicatorColor = Colors
          .white // Green for both success and failure (or use successColor/errorColor)
      ..maskType = EasyLoadingMaskType.none
      ..textColor = Colors.white // Black for text (default or your preference)
      ..loadingStyle = EasyLoadingStyle.custom;

    EasyLoading.showSuccess(title);
  }

  static failure([String title = 'حدث خطأ']) {
    EasyLoading.instance
      ..backgroundColor =
          AppColors.redButton // Or your desired background color
      ..indicatorColor = Colors
          .white // Green for both success and failure (or use successColor/errorColor)
      ..textColor = Colors.white // Black for text (default or your preference)
      ..maskType = EasyLoadingMaskType.none
      ..loadingStyle = EasyLoadingStyle.custom;

    EasyLoading.showError(title);
  }

  static loading([String title = 'برجاء الانتظار...']) {
    EasyLoading.instance
      ..backgroundColor = AppColors.white // Or your desired background color
      ..indicatorColor = AppColors.primaryColor
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..maskType = EasyLoadingMaskType.black
      ..textColor =
          AppColors.primaryColor // Black for text (default or your preference)
      ..loadingStyle = EasyLoadingStyle.custom;

    EasyLoading.show(status: title);
  }

  static dissmissLoading([String title = 'حدث خطأ']) {
    EasyLoading.dismiss();
  }

  static displayLoading3([String title = 'برجاء الانتظار...']) {
    EasyLoading.instance
      ..backgroundColor = AppColors.black // Or your desired background color
      ..indicatorColor = AppColors.white
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..maskType = EasyLoadingMaskType.black
      ..textColor =
          AppColors.white // Black for text (default or your preference)
      ..loadingStyle = EasyLoadingStyle.custom;

    EasyLoading.show(status: title);
  }

  static displayLoading2([String title = 'برجاء الانتظار...']) {
    EasyLoading.instance
      ..backgroundColor = AppColors.white // Or your desired background color
      ..indicatorColor = AppColors.secondaryColor
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..maskType = EasyLoadingMaskType.black
      ..textColor = AppColors
          .secondaryColor // Black for text (default or your preference)
      ..loadingStyle = EasyLoadingStyle.custom;

    EasyLoading.show(status: title);
  }
}
