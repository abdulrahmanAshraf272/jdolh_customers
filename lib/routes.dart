import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/screens/home_screen.dart';
import 'package:jdolh_customers/view/screens/language_screen.dart';

List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => const LanguageScreen(),
  ),
  GetPage(name: AppRouteName.home, page: () => const HomeScreen()),
];
