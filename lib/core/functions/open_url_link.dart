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
