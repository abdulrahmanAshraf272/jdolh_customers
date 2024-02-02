import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/send_verifycode_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/test_screen.dart';
import 'package:jdolh_customers/view/screens/auth/login_screen.dart';
import 'package:jdolh_customers/view/screens/auth/reset_password_screen.dart';
import 'package:jdolh_customers/view/screens/auth/send_verifycode_screen.dart';
import 'package:jdolh_customers/view/screens/auth/signup_screen.dart';
import 'package:jdolh_customers/view/screens/auth/success_screen.dart';
import 'package:jdolh_customers/view/screens/auth/verifycode_screen.dart';
import 'package:jdolh_customers/view/screens/home_screen.dart';
import 'package:jdolh_customers/view/screens/language_screen.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => const SignupScreen()),
  //GetPage(name: '/', page: () => const LanguageScreen()),
  GetPage(name: AppRouteName.home, page: () => const HomeScreen()),
];
