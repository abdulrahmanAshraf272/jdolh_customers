import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

askForlocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Get.defaultDialog(
          title: "Warning",
          middleText: "You should allow use location to continue.");
      return;
    }
  }
}
