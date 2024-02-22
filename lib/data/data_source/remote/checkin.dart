import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';
import 'package:jdolh_customers/core/constants/strings.dart';

class CheckinData {
  Crud crud;
  CheckinData(this.crud);

  getGooglePlaces({
    required String lat,
    required String lng,
    String type = '',
    String keywords = '',
    String radius = '100',
    String language = 'ar',
  }) async {
    var response = await crud.getData(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$keywords&location=$lat,$lng&radius=$radius&type=$type&key=$GOOGLE_MAPS_API_KEY&language=$language');

    return response.fold((l) => l, (r) => r);
  }

  getJdolhPlaces() async {
    var response = await crud.getData(ApiLinks.jdolhPlaces);

    return response.fold((l) => l, (r) => r);
  }

  checkin(
      String userid,
      String fromGoogle,
      String gmId,
      String name,
      String type,
      String location,
      String lat,
      String lng,
      String comment,
      String friends) async {
    var response = await crud.postData(ApiLinks.checkin, {
      "userid": userid,
      "fromGoogle": fromGoogle,
      "gmId": gmId,
      "name": name,
      "type": type,
      "location": location,
      "lat": lat,
      "lng": lng,
      "comment": comment,
      "friends": friends
    });

    return response.fold((l) => l, (r) => r);
  }
}
