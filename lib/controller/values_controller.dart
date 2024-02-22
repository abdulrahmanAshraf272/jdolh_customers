import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';

class ValuesController extends GetxController {
  List<Friend> myfollowers = [];
  List<Friend> myfollowing = [];
  List<Occasion> myOccasions = [];
  List<Occasion> acceptedOccasions = [];
  List<Occasion> suspendedOccasions = [];

  static LatLng? latLngSelected;

  LatLng? currentPosition;

  bool isRefresh = false;

  removeOccasion(Occasion occasion) {
    myOccasions.remove(occasion);
    resetAcceptedAndSuspendedList();
  }

  addOccasion(Occasion occasion) {
    myOccasions.add(occasion);
    resetAcceptedAndSuspendedList();
  }

  editOccasion(int occasionId, String title, String datetime, String location,
      String lat, String long) {
    Occasion desireOccasion =
        myOccasions.firstWhere((element) => element.occasionId == occasionId);
    desireOccasion.occasionTitle = title;
    desireOccasion.occasionDatetime = datetime;
    desireOccasion.occasionLocation = location;
    desireOccasion.occasionLat = lat;
    desireOccasion.occasionLong = long;
    resetAcceptedAndSuspendedList();
  }

  void addAndRemoveFollowing(Friend friend) {
    bool found = false;
    int foundIndex = -1;

    for (int i = 0; i < myfollowing.length; i++) {
      if (myfollowing[i].userId == friend.userId) {
        found = true;
        foundIndex = i;
        break;
      }
    }

    if (found) {
      // Remove the friend from the list
      myfollowing..removeAt(foundIndex);
      print('Friend removed from the list.');
    } else {
      // Add the friend to the list
      myfollowing.add(friend);
      print('Friend  added to the list.');
    }
  }

  resetAcceptedAndSuspendedList() {
    acceptedOccasions.clear();
    suspendedOccasions.clear();
    for (var element in myOccasions) {
      if (element.acceptstatus == 1) {
        acceptedOccasions.add(element);
      } else if (element.acceptstatus == 0) {
        suspendedOccasions.add(element);
      }
    }
  }

  changeInvitorStatus(int occasionId, int status) {
    Occasion desireOccasion =
        myOccasions.firstWhere((element) => element.occasionId == occasionId);
    desireOccasion.acceptstatus = status;
    resetAcceptedAndSuspendedList();
  }
}
