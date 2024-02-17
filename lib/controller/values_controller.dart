import 'package:get/get.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';

class ValuesController extends GetxController {
  List<PersonWithFollowState> myfollowers = [];
  List<PersonWithFollowState> myfollowing = [];
  List<Occasion> myOccasions = [];
  List<Occasion> acceptedOccasions = [];
  List<Occasion> suspendedOccasions = [];

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

  resetAcceptedAndSuspendedList() {
    acceptedOccasions.clear();
    suspendedOccasions.clear();
    for (var element in myOccasions) {
      if (element.acceptstatus == 1) {
        acceptedOccasions.add(element);
      } else {
        suspendedOccasions.add(element);
      }
    }
  }
}
