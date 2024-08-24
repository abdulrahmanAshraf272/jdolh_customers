import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts {
  final String name;
  final String number;

  Contacts({required this.name, required this.number});
}

class MyContactsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  ValuesController valuesController = Get.put(ValuesController());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  MyServices myServices = Get.find();
  List<Friend> users = [];
  List<Contacts> contacts = [];
  bool readContact = true;

  List<Friend> usersBeforeFilter = [];
  List<Contacts> contactsBeforeFilter = [];

  void updateList(String value) {
    value = value.toLowerCase();
    contacts = contactsBeforeFilter
        .where((element) => element.name.toLowerCase().contains(value))
        .toList();
    users = usersBeforeFilter
        .where((element) =>
            element.userUsername!.toLowerCase().contains(value) ||
            element.userName!.toLowerCase().contains(value))
        .toList();
    update();
  }

  // void updateList(String value) {
  //   contacts = contactsBeforeFilter
  //       .where((element) => element.name.contains(value))
  //       .toList();
  //   users = usersBeforeFilter
  //       .where((element) =>
  //           element.userUsername!.contains(value) ||
  //           element.userName!.contains(value))
  //       .toList();
  //   update();
  // }

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

    // Modify the phone number based on the prefix
    if (friendNumber.startsWith('01')) {
      friendNumber =
          '20' + friendNumber.substring(1); // Remove '0' and add '20'
    } else if (friendNumber.startsWith('05')) {
      friendNumber =
          '966' + friendNumber.substring(1); // Remove '0' and add '966'
    }
    print('number after edit: $friendNumber');

    // Replace 'YourAppName' with your app name
    final String appLink =
        'https://play.google.com/store/apps/details?id=com.jdolh.reservations.appointments'; // Google Play Store link
    // final String appLink = 'https://apps.apple.com/app/idxxxxxxxxx'; // App Store link

    // Create the invitation message
    final String message =
        'مرحبًا، اكتشف تطبيق JDOLH. تطبيق رائع . قم بتنزيله من: $appLink';

    // Encode the message and phone number
    final String encodedMessage = Uri.encodeComponent(message);
    final String encodedPhoneNumber = Uri.encodeComponent(friendNumber);

    // Construct the SMS URI
    final String smsUri = 'sms:$encodedPhoneNumber?body=$encodedMessage';

    // Construct the WhatsApp URI
    final String whatsappUri =
        'https://wa.me/$friendNumber?text=$encodedMessage';

    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: AppColors.gray,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'اختر طريقة ارسال الدعوة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 20),
          GoHomeButton(
              onTap: () async {
                if (await canLaunchUrl(Uri.parse(smsUri))) {
                  await launchUrl(Uri.parse(smsUri));
                } else {
                  Get.rawSnackbar(message: 'غير مسموح بالوصول لرسايل sms لديك');
                }
              },
              text: "عبر رسالة SMS",
              width: Get.width - 40,
              height: 38.h),
          const SizedBox(height: 10),
          GoHomeButton(
              onTap: () async {
                // Check if WhatsApp is installed
                if (await canLaunchUrl(Uri.parse(whatsappUri))) {
                  await launchUrl(Uri.parse(whatsappUri));
                } else {
                  Get.rawSnackbar(
                      message:
                          'لا يمكن ارسال الدعوة عبد Whatsapp لان التطبيق غير مثبت او عليه حماية معينة');
                }
              },
              text: 'عبر Whatsapp',
              width: Get.width - 40,
              height: 38.h),
        ],
      ),
    ));

    // // Check if WhatsApp is installed
    // if (await canLaunchUrl(Uri.parse(whatsappUri))) {
    //   await launchUrl(Uri.parse(whatsappUri));
    // }
    // // Otherwise, fallback to the SMS app
    // else if (await canLaunchUrl(Uri.parse(smsUri))) {
    //   await launchUrl(Uri.parse(smsUri));
    // } else {
    //   throw 'Could not launch messaging app';
    // }
  }

  // void sendInvitation(int index) async {
  //   String friendNumber = contacts[index].number;
  //   // Replace 'YourAppName' with your app name
  //   final String appLink =
  //       'https://play.google.com/store/apps/details?id=com.jdolh.reservations.appointments'; // Google Play Store link
  //   // final String appLink = 'https://apps.apple.com/app/idxxxxxxxxx'; // App Store link

  //   // Create the invitation message
  //   final String message =
  //       'مرحبًا، اكتشف تطبيق JDOLH. إنه تطبيق رائع . قم بتنزيله من: $appLink';

  //   // Encode the message and phone number
  //   final String encodedMessage = Uri.encodeFull(message);
  //   final String encodedPhoneNumber = Uri.encodeFull(friendNumber);

  //   // Construct the SMS URI
  //   final String uri = 'sms:$encodedPhoneNumber?body=$encodedMessage';

  //   // Launch the messaging app
  //   if (await canLaunchUrl(Uri.parse(uri))) {
  //     await launchUrl(Uri.parse(uri));
  //   } else {
  //     throw 'Could not launch $uri';
  //   }
  // }

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

        usersBeforeFilter = List.of(users);
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
      contactsBeforeFilter = List.of(contacts);

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
