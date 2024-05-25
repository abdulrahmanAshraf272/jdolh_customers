import 'package:get/get.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/services/services.dart';

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
}
