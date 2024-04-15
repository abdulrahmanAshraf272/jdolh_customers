//import 'package:geolocator/geolocator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  //Any thing want to be init when the app open but it in this function.
  Future<MyServices> init() async {
    //await Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
    //locationPermissionRequest();
    return this;
  }

  setUserData(User user) {
    print('image ${user.image}');
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
