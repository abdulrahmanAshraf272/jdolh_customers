import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class ServerKeyData {
  Crud crud;
  ServerKeyData(this.crud);

  getServerKey() async {
    var response = await crud.getData(ApiLinks.getServerKey);

    return response.fold((l) => l, (r) => r);
  }
}
