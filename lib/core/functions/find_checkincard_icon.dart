import 'package:flutter/material.dart';

IconData findSuitableIconForCard(String type) {
  IconData iconData;
  if (type == 'restaurant' || type == 'food') {
    iconData = Icons.restaurant;
  } else if (type == 'cafe') {
    iconData = Icons.local_cafe;
  } else if (type == 'point_of_interest') {
    iconData = Icons.location_city;
  } else if (type == 'supermarket') {
    iconData = Icons.store;
  } else if (type == 'clothing_store') {
    iconData = Icons.store;
  } else if (type == 'car_wash') {
    iconData = Icons.local_car_wash;
  } else if (type == 'atm' || type == 'bank') {
    iconData = Icons.attach_money;
  } else {
    iconData = Icons.location_city;
  }

  return iconData;
}
