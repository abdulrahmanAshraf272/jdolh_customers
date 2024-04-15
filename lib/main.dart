import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jdolh_customers/core/binding/initial_binding.dart';
import 'package:jdolh_customers/core/localization/change_locale.dart';
import 'package:jdolh_customers/core/localization/translation.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initialServices();
  initializeDateFormatting('ar');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'JDOLH',
          debugShowCheckedModeBanner: false,
          locale: controller.language,
          translations: MyTranslation(),
          theme: controller.appTheme,
          initialBinding: InitialBindings(),
          getPages: routes,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
