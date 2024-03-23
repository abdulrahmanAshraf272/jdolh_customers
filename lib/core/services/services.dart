//import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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

  setUserid(int id) {
    sharedPreferences.setString("id", id.toString());
  }

  String getUserid() {
    return sharedPreferences.getString("id") ?? '0';
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
