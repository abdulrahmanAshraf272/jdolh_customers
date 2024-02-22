import 'package:geolocator/geolocator.dart';

class LocationService {
  final Geolocator _geolocator = Geolocator();

  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<void> requestLocationPermission() async {
    await Geolocator.requestPermission();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> requestLocationService() async {
    if (!await isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool hasPermission = await checkLocationPermission();
    if (!hasPermission) {
      await requestLocationPermission();
    }

    bool isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await requestLocationService();
    }

    if (hasPermission && isServiceEnabled) {
      try {
        return await Geolocator.getCurrentPosition();
      } catch (e) {
        print("Error getting location: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}
