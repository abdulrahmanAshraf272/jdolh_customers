import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ReservationNotification {
  MyServices myServices = Get.find();
  String wantString = 'يرغب';
  String reserveString = 'الحجز';
  String yourStoreString = 'متجرك';
  String inString = 'في';
  String reserveOrderString = 'لديك طلب حجز';
  String dateString = 'بتاريخ';

  String newReservationString = 'لديك حجز جديد';
  String didString = 'لقد';
  String didReserveString = 'حجز';

  String cancelReservationString = 'لديك حجز ملغي';
  String canelString = 'الغى';

  divideBillNotifications(
      List<Friend> friends, String myName, String myImage, int resId) {
    for (int i = 0; i < friends.length; i++) {
      NotificationSender.sendToCustomer(
          userid: friends[i].userId!,
          title: 'لديك فاتورة جديدة',
          body: 'لقد قام $myName بتقسييم فاتورة حجز رقم $resId معك',
          image: "${ApiLinks.customerImage}/$myImage",
          routeName: AppRouteName.bills);
    }
  }

  sendReserveRequistNotification(int bchid, String date, int resid) {
    String myUsername = myServices.getUsername();
    NotificationSender.sendToBch(
        bchid: bchid,
        title: reserveOrderString,
        body:
            '$wantString $myUsername $reserveString $inString $yourStoreString $dateString $date',
        routeName: '/reservationDetails',
        objectId: resid);
  }

  sendReserveNotification(int bchid, String date, int resid) {
    String myUsername = myServices.getUsername();
    NotificationSender.sendToBch(
        bchid: bchid,
        title: newReservationString,
        body:
            '$didString $didReserveString $myUsername $inString $yourStoreString $dateString $date',
        routeName: '/reservationDetails',
        objectId: resid);
  }

  cancelReservation(int bchid, String date) {
    String myUsername = myServices.getUsername();
    NotificationSender.sendToBch(
        bchid: bchid,
        title: cancelReservationString,
        body:
            '$didString $canelString $myUsername $reserveString $inString $yourStoreString $dateString $date',
        routeName: '/reservations');
  }

  sendInvitations(List<Resinvitors> resInvitors, Reservation reservation) {
    String myName = myServices.getName();
    String date = reservation.resDate!;
    for (int i = 0; i < resInvitors.length; i++) {
      NotificationSender.sendToCustomer(
          userid: resInvitors[i].userid!,
          title: 'دعوة من $myName ',
          body: 'لديك دعوة حجز بتاريخ $date',
          routeName: AppRouteName.schedule);
    }
  }
}
