import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/data/models/friend.dart';

abstract class OccasionNotification {
  static sendOccasionInvitation(List<Friend> friends, String occasionTitle,
      String myName, String myImage, int occasionid, String datetime) {
    for (int i = 0; i < friends.length; i++) {
      NotificationSender.sendToCustomer(
          userid: friends[i].userId!,
          title: 'دعوة الى مناسبة',
          body: 'لقد قام $myName بدعوتك الى $occasionTitle',
          image: "${ApiLinks.customerImage}/$myImage",
          objectId: occasionid,
          routeName: AppRouteName.occasionDetails,
          datetime: datetime);
    }
  }

  static editOccasion(List<Friend> friends, String myName, String myImage,
      String occasionTitle, int occasionid, String datetime) {
    for (int i = 0; i < friends.length; i++) {
      NotificationSender.sendToCustomer(
          userid: friends[i].userId!,
          title: 'تم تعديل مناسبة $occasionTitle',
          body: 'قام $myName بتعديل مناسبة $occasionTitle',
          objectId: occasionid,
          image: "${ApiLinks.customerImage}/$myImage",
          routeName: AppRouteName.occasionDetails,
          datetime: datetime);
    }
  }

  static acceptOccasion(
    int userid,
    String myName,
    String myImage,
    String occasionTitle,
  ) {
    NotificationSender.sendToCustomer(
      userid: userid,
      title: 'تأكيد حضور للمناسبة',
      body: 'لقد قام $myName بتأكيد حضوره الى $occasionTitle',
      image: "${ApiLinks.customerImage}/$myImage",
      routeName: AppRouteName.occasions,
    );
  }

  static rejectOccasion(
    int userid,
    String myName,
    String myImage,
    String occasionTitle,
    String excuse,
  ) {
    String rejectionText = excuse == '' ? '' : 'بسبب $excuse';
    NotificationSender.sendToCustomer(
        userid: userid,
        title: 'اعتذار عن الحضور',
        body: 'لقد قام $myName بلإعتذار عن حضور $occasionTitle $rejectionText',
        image: "${ApiLinks.customerImage}/$myImage",
        routeName: AppRouteName.occasions);
  }
}
