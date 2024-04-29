import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/models/friend.dart';

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
  ValuesController valuesController = Get.put(ValuesController());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  MyServices myServices = Get.find();
  List<Friend> users = [];
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

  followUnfollow(int index) {
    followUnfollowRequest(users[index].userId.toString());
    valuesController.addAndRemoveFollowing(users[index]);
    if (users[index].following!) {
      users[index].following = false;
    } else {
      users[index].following = true;
    }
    update();
  }

  followUnfollowRequest(String personId) async {
    var response = await followUnfollowData.postData(
        myServices.sharedPreferences.getString("id")!, personId);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('operation followUnfollow done succussfuly');
      } else {
        print('operation followUnfollow done failed');
      }
    }
  }

  onTapCard(int index) {
    Get.toNamed(AppRouteName.personProfile, arguments: users[index])!
        .then((value) => update());
  }

  getAllUsers() async {
    var response = await followUnfollowData.getAllUsers(
        myId: myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseJsonData = response['data'];
        //parsing jsonList to DartList.
        users = responseJsonData.map((e) => Friend.fromJson(e)).toList();
        removeUsersNotExistInMyContact();
        removeContactsExistInJdolh();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  removeUsersNotExistInMyContact() {
    List<String> contactsNumber =
        contacts.map((e) => removeSpaces(e.number)).toList();

    users.removeWhere(
        (user) => !contactsNumber.contains(removeSpaces(user.phone!)));
  }

  removeContactsExistInJdolh() {
    List<String> usersPhone = users.map((e) => removeSpaces(e.phone!)).toList();
    contacts.removeWhere(
        (element) => usersPhone.contains(removeSpaces(element.number)));
  }

  String removeSpaces(String input) {
    return input.replaceAll(' ', '');
  }

  @override
  void onInit() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      contacts = await getContacts();
      await getAllUsers();
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
