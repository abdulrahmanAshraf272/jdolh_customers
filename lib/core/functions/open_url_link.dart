import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void openUrlLink(String locationLink) async {
  // Check if the URL can be launched
  if (await canLaunchUrl(Uri.parse(locationLink))) {
    // Launch the URL in the default browser or app
    await launchUrl(Uri.parse(locationLink));
  } else {
    // Handle the case where the URL can't be launched
    Get.rawSnackbar(message: 'الرابط غير صالح');
    print('Could not launch $locationLink');
  }
}

Future<void> openContactApp(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
