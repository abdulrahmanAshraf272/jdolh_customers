//import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/notification/notification_data.dart';
import 'package:jdolh_customers/core/notification/notification_handler.dart';
import 'package:jdolh_customers/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  //Any thing want to be init when the app open but it in this function.
  Future<MyServices> init() async {
    //Firebase
    await Firebase.initializeApp(); // Initialize Firebase
    sharedPreferences = await SharedPreferences.getInstance();
    requestNotificationPermission();
    onClickNotificationOnTerminated();
    onClickNotificatoinOnBackground();
    handlingNotificationOnForground();
    handlingNotificationOnBackgroundAndTerminated();

    //locationPermissionRequest();
    return this;
  }

  setPaymentMethods(String method) {
    sharedPreferences.setString("paymentMethod", method);
  }

  String getPaymentMethods() {
    return sharedPreferences.getString("paymentMethod") ?? 'CREDIT';
  }

  setUserData(User user) {
    sharedPreferences.setString("name", user.userName ?? '');
    sharedPreferences.setString("username", user.userUsername ?? '');
    sharedPreferences.setString("image", user.image ?? '');
    sharedPreferences.setString("phone", user.userPhone ?? '');
    sharedPreferences.setString("city", user.userCity ?? '');
    sharedPreferences.setString("email", user.userEmail ?? '');
    sharedPreferences.setString("gender", user.userGender.toString());
    sharedPreferences.setString("id", user.userId.toString());
  }

  setStep(String step) {
    sharedPreferences.setString("step", step);
  }

  setUserid(int id) {
    sharedPreferences.setString("id", id.toString());
  }

  String getUserid() {
    return sharedPreferences.getString("id") ?? '0';
  }

  String getName() {
    return sharedPreferences.getString("name") ?? '';
  }

  String getUsername() {
    return sharedPreferences.getString("username") ?? '';
  }

  String getGender() {
    return sharedPreferences.getString("gender") ?? '1';
  }

  String getEmail() {
    return sharedPreferences.getString("email") ?? '';
  }

  String getCity() {
    return sharedPreferences.getString("city") ?? '';
  }

  String getPhone() {
    return sharedPreferences.getString("phone") ?? '';
  }

  String getImage() {
    return sharedPreferences.getString("image") ?? '';
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
