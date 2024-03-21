import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/constants/strings.dart';

class GoogleMapsService {
  Crud crud;
  GoogleMapsService(this.crud);

  getSearchSuggestations(
      {required String lat,
      required String lng,
      required String input,
      required String sessiontoken,
      required String radius,
      // String language = 'ar',
      String country = 'eg'}) async {
    var response = await crud.getData(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:$country&key=$GOOGLE_MAPS_API_KEY&sessiontoken=$sessiontoken&radius=$radius&location=$lat, $lng');

    return response.fold((l) => l, (r) => r);
  }

  getPlaceDetails(
      {required String placeId, required String sessiontoken}) async {
    var response = await crud.getData(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&sessiontoken=$sessiontoken&key=$GOOGLE_MAPS_API_KEY&fields=geometry');

    return response.fold((l) => l, (r) => r);
  }
}
