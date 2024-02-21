import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

int calculateDistance(double lat1, double long1, double lat2, double long2) {
  const double earthRadius = 6371000; // Radius of the Earth in meters

  double toRadians(double degree) {
    return degree * pi / 180.0;
  }

  double deltaLat = toRadians(lat2 - lat1);
  double deltaLong = toRadians(long2 - long1);

  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(toRadians(lat1)) *
          cos(toRadians(lat2)) *
          sin(deltaLong / 2) *
          sin(deltaLong / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  int distance = (earthRadius * c).round();
  return distance;
}

List<LatLng> findAddressesNearby(
    LatLng myAddress, List<LatLng> addresses, double maxDistance) {
  double haversine(LatLng p1, LatLng p2) {
    const double radiusEarth = 6371000; // Radius of the Earth in meters

    double toRadians(double degree) {
      return degree * (pi / 180.0);
    }

    double dLat = toRadians(p2.latitude - p1.latitude);
    double dLon = toRadians(p2.longitude - p1.longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(toRadians(p1.latitude)) *
            cos(toRadians(p2.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radiusEarth * c;
  }

  // List<LatLng> addresses = [
  //   LatLng(31.260, 29.980),
  //   LatLng(31.255, 29.982),
  //   LatLng(31.259, 29.979),
  //   LatLng(31.263, 29.985),
  // ];

  // double maxDistance = 100; // 100 meters

  // List<LatLng> addressesNearby = findAddressesNearby(myAddress, addresses, maxDistance);

  // print("Addresses nearby: $addressesNearby");

  List<LatLng> nearbyAddresses = [];

  for (LatLng address in addresses) {
    double distance = haversine(myAddress, address);
    if (distance < maxDistance) {
      nearbyAddresses.add(address);
    }
  }

  return nearbyAddresses;
}
