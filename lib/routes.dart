import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/send_verifycode_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/test_screen.dart';
import 'package:jdolh_customers/test_screen2.dart';
import 'package:jdolh_customers/view/screens/appt_details_screen.dart';
import 'package:jdolh_customers/view/screens/auth/login_screen.dart';
import 'package:jdolh_customers/view/screens/auth/reset_password_screen.dart';
import 'package:jdolh_customers/view/screens/auth/send_verifycode_screen.dart';
import 'package:jdolh_customers/view/screens/auth/signup_screen.dart';
import 'package:jdolh_customers/view/screens/auth/success_screen.dart';
import 'package:jdolh_customers/view/screens/auth/verifycode_screen.dart';
import 'package:jdolh_customers/view/screens/home_screen.dart';
import 'package:jdolh_customers/view/screens/language_screen.dart';
import 'package:jdolh_customers/view/screens/main_screen.dart';
import 'package:jdolh_customers/view/screens/schedule_screen.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => const TestScreen2()),
  //GetPage(name: '/', page: () => const LanguageScreen()),
  GetPage(name: AppRouteName.home, page: () => const HomeScreen()),
];
