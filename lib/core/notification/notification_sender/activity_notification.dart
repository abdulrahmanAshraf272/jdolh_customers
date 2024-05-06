import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/models/friend.dart';

class ActivityNotification {
  ValuesController valuesController = Get.put(ValuesController());
  MyServices myServices = Get.find();

  String doString = "قام";
  String rateString = 'بتقييم';
  String bchString = 'فرع';
  String starsString = 'نجوم';
  String checkinString = 'تسجيل وصول';
  String to = 'الى';

  sendCheckinActivityToFollowers(int userid, String placeName) {
    String myId = myServices.getUserid();
    String myName = myServices.getName();
    String myImage = myServices.getImage();
    NotificationSender.sendToMyFollower(
        myId: myId,
        userid: userid,
        title: checkinString,
        body: '$doString $myName $checkinString $to $placeName',
        image: myImage);

    // for (int i = 0; i < myFollowers.length; i++) {
    //   NotificationSender.sendToCustomer(
    //       userid: myFollowers[i].userId!,
    //       title: checkinString,
    //       body: '$doString $myName $checkinString $to $placeName',
    //       image: myImage);
    // }
  }

  sendRateActivityToFollowers(String placeName, String bchName, double rate) {
    List<Friend> myFollowers = valuesController.myfollowers;
    String myName = myServices.getName();
    String myImage = myServices.getImage();
    for (int i = 0; i < myFollowers.length; i++) {
      NotificationSender.sendToCustomer(
          userid: myFollowers[i].userId!,
          title: '$doString $myName $rateString $placeName',
          body:
              '$doString $myName $rateString $placeName $bchString $bchName $rate $starsString',
          image: myImage);
    }
  }

  sendRateToBch(int bchid, String bchName, double rate) {
    String myName = myServices.getName();
    NotificationSender.sendToBch(
        bchid: bchid,
        title: 'تقييم جديد',
        body: 'قام $myName بتقييم متجرك فرع $bchName $rate نجوم');
  }
}
