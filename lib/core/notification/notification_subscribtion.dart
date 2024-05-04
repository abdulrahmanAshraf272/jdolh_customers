import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/notification/notification_const.dart';

abstract class NotificationSubscribtion {
  // ===== User ======//
  static userSubscribeToTopic(int? id, String? city, int? gender) {
    if (id == null || city == null || gender == null) {
      return;
    }
    String cityInEnglish = cityTranslations[city] ?? '';
    subscribeToTopic(allUserSubscribe);
    subscribeToTopic('$userSubscribe-$id');
    subscribeToTopic('$userCitySubscribe-$cityInEnglish');
    subscribeToTopic('$userGenderSubscribe-$gender');
  }

  static userUnsubscribeToTopic(int? id, String? city, int? gender) {
    if (id == null || city == null || gender == null) {
      return;
    }
    String cityInEnglish = cityTranslations[city] ?? '';
    unsubscribeFromTopic(allUserSubscribe);
    unsubscribeFromTopic('$userSubscribe-$id');
    unsubscribeFromTopic('$userCitySubscribe-$cityInEnglish');
    unsubscribeFromTopic('$userGenderSubscribe-$gender');
  }

  static followUserSubcribeToTopic(int? followerid) {
    if (followerid == null) return;

    subscribeToTopic('$followUserSubscribe-$followerid');
  }

  static unfollowUserSubcribeToTopic(int? followerid) {
    if (followerid == null) return;
    unsubscribeFromTopic('$followUserSubscribe-$followerid');
  }

  static followBchSubcribeToTopic(int? bchid) {
    if (bchid == null) return;

    subscribeToTopic('$followBchSubscribe-$bchid');
  }

  static unfollowBchSubcribeToTopic(int? bchid) {
    if (bchid == null) return;
    unsubscribeFromTopic('$followBchSubscribe-$bchid');
  }

  static subscribeToTopic(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static unsubscribeFromTopic(String topic) {
    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }
}
