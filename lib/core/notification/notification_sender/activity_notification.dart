import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/services/services.dart';

class ActivityNotification {
  MyServices myServices = Get.find();

  String doString = "قام";
  String rateString = 'بتقييم';
  String bchString = 'فرع';
  String starsString = 'نجوم';
  String checkinString = 'تسجيل وصول';
  String to = 'الى';

  sendCheckinActivityToFollowers(String placeName) {
    String myId = myServices.getUserid();
    String myName = myServices.getName();
    String myImage = myServices.getImage();
    NotificationSender.sendToMyFollower(
        myId: myId,
        title: checkinString,
        body: '$doString $myName $checkinString $to $placeName',
        image: "${ApiLinks.customerImage}/$myImage");
  }

  sendRateActivityToFollowers(int bchid, String placeName, String bchName,
      String brandImage, double rate) {
    String myId = myServices.getUserid();
    String myName = myServices.getName();

    NotificationSender.sendToMyFollower(
        myId: myId,
        title: '$doString $myName $rateString $placeName',
        body:
            '$doString $myName $rateString $placeName $bchString $bchName $rate $starsString',
        image: "${ApiLinks.logoImage}/$brandImage",
        routeName: AppRouteName.brandProfile,
        objectId: bchid);
  }

  sendRateToBch(int bchid, String bchName, double rate) {
    String myName = myServices.getName();
    NotificationSender.sendToBch(
        bchid: bchid,
        title: 'تقييم جديد',
        body: 'قام $myName بتقييم متجرك فرع $bchName $rate نجوم');
  }
}
