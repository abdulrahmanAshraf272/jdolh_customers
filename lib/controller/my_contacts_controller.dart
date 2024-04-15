import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts {
  final String name;
  final String number;

  Contacts({required this.name, required this.number});
}

class MyContactsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  List<Contacts> contacts = [];
  bool readContact = true;

  Future<List<Contacts>> getContacts() async {
    // Request permission to access contacts

    var status = await Permission.contacts.request();

    if (status.isGranted) {
      // Permission granted, fetch contacts
      statusRequest = StatusRequest.loading;
      Iterable<Contact> contacts = await ContactsService.getContacts();

      // Map fetched contacts to custom Contacts class
      List<Contacts> contactList = contacts
          .map((contact) => Contacts(
                name: contact.displayName ?? 'Unknown',
                number: contact.phones?.isNotEmpty == true
                    ? contact.phones!.first.value ?? ''
                    : '',
              ))
          .toList();

      return contactList;
    } else {
      // Permission denied or restricted
      readContact = false;
      update();
      throw Exception('Permission to access contacts denied');
    }
  }

  void sendInvitation(int index) async {
    String friendNumber = contacts[index].number;
    // Replace 'YourAppName' with your app name
    final String appLink =
        'https://play.google.com/store/apps/details?id=com.jdolh.reservations.appointments'; // Google Play Store link
    // final String appLink = 'https://apps.apple.com/app/idxxxxxxxxx'; // App Store link

    // Create the invitation message
    final String message =
        'مرحبًا، اكتشف تطبيق JDOLH. إنه تطبيق رائع . قم بتنزيله من: $appLink';

    // Encode the message and phone number
    final String encodedMessage = Uri.encodeFull(message);
    final String encodedPhoneNumber = Uri.encodeFull(friendNumber);

    // Construct the SMS URI
    final String uri = 'sms:$encodedPhoneNumber?body=$encodedMessage';

    // Launch the messaging app
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  void onInit() async {
    try {
      contacts = await getContacts();
      statusRequest = StatusRequest.success;
      update();
      // Do something with the fetched contacts
      print('Contacts: ${contacts[0].name}');
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
    super.onInit();
  }
}
