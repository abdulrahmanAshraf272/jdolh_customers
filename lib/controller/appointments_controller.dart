import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/is_date_passed.dart';
import 'package:jdolh_customers/core/notification/notification_sender/occasion_notification.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class AppointmentsController extends GetxController {
  OccasionsData occasionData = OccasionsData(Get.find());
  TextEditingController excuse = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());
  MyServices myServices = Get.find();

  List<Reservation> allRes = [];
  List<Reservation> resToDisplay = [];
  List<Reservation> reservationComming = [];
  List<Reservation> reservationNeedApproval = [];

  List<Occasion> occasionsToDisplay = [];
  List<Occasion> myOccasions = [];
  List<Occasion> acceptedOccasions = [];
  List<Occasion> suspendedOccasions = [];

  String arabicDate = '';
  DateTime selectedDate = DateTime.now();
  String selectedDateFormatted =
      DateFormat('yyyy-MM-dd').format(DateTime.now());
  //int needApproveOccasionsNo = 0;

  bool displayCommingAppt = true;

  int apptNeedApproveNo = 0;

  changeDisplayCommingApptStatus(bool displayComming) {
    displayCommingAppt = displayComming;
    setResToDisplay();
    setOccasionsToDisplay();

    apptNeedApproveNo =
        suspendedOccasions.length + reservationNeedApproval.length;
    update();
  }

  displayAllAppointment() {
    arabicDate = 'عرض الكل'.tr;

    //Reservation
    resToDisplay.clear();
    resToDisplay = List.of(reservationComming);

    //Occasions
    occasionsToDisplay.clear();
    occasionsToDisplay = List.of(acceptedOccasions);

    update();
  }

  gotoReservationDetails(int index) async {
    final result;

    if (resToDisplay[index].resWithInvitors == 0) {
      result = await Get.toNamed(AppRouteName.reservationDetails,
          arguments: {"res": resToDisplay[index]});
    } else {
      result = await Get.toNamed(AppRouteName.reservationWithInvitors,
          arguments: {"res": resToDisplay[index]});
    }

    if (result != null) {
      getAppointments();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      selectedDateFormatted = DateFormat('yyyy-MM-dd').format(selectedDate);

      getArabicDate(selectedDate);

      setResToDisplay();
      setOccasionsToDisplay();
      update();
    }
  }

  getArabicDate(DateTime dateTime) {
    String langCode = myServices.sharedPreferences.getString('lang') ?? 'ar';

    final dayName = DateFormat('EEEE', langCode);
    final month = DateFormat('MMMM', langCode);
    final day = DateFormat('dd');
    final year = DateFormat('yyyy');

    final dayNameFormat = dayName.format(dateTime);
    final monthFormat = month.format(dateTime);
    final dayFormat = day.format(dateTime);
    final yearFormat = year.format(dateTime);

    final date = "$dayNameFormat, $dayFormat $monthFormat, $yearFormat";
    arabicDate = date;
  }

  String displayResTime(int index) {
    String timeString = resToDisplay[index].resTime!;
    timeString = timeString.trim();
    DateTime time = DateFormat.Hm().parse(timeString);
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  Future getAllRes() async {
    var response = await resData.getAllMyRes(userid: myServices.getUserid());
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        parseValues(response);
      } else {
        print('failure');
      }
    }
  }

  parseValues(response) {
    allRes.clear();
    reservationComming.clear();
    reservationNeedApproval.clear();

    List data = response['data'];
    allRes = data.map((e) => Reservation.fromJson(e)).toList();

    for (int i = 0; i < allRes.length; i++) {
      if (allRes[i].resStatus != 3) {
        allRes.removeAt(i);
      }
    }

    allRes.sort((a, b) {
      DateTime dateA = DateTime.parse(a.resDate!);
      DateTime dateB = DateTime.parse(b.resDate!);
      return dateA.compareTo(dateB);
    });

    resetCommingAndNeedToApproveLists();

    setResToDisplay();
  }

  resetCommingAndNeedToApproveLists() {
    for (int i = 0; i < allRes.length; i++) {
      if (allRes[i].resStatus == 3) {
        if (allRes[i].creator == 1 || allRes[i].invitorStatus == 1) {
          reservationComming.add(allRes[i]);
          print(reservationComming.length);
        } else if (allRes[i].creator == 0 && allRes[i].invitorStatus == 0) {
          reservationNeedApproval.add(allRes[i]);
        }
      }
    }
  }

  setResToDisplay() {
    resToDisplay.clear();
    if (displayCommingAppt) {
      getArabicDate(selectedDate);
      for (int i = 0; i < reservationComming.length; i++) {
        if (reservationComming[i].resDate == selectedDateFormatted) {
          resToDisplay.add(reservationComming[i]);
        }
      }
    } else {
      resToDisplay = List.from(reservationNeedApproval);
    }
  }

  ////////////////////////////////////////////////////////////////////////
  ////= ======================  Occasions ==========================/////
  onTapOccasionCard(int index) async {
    final result;
    if (occasionsToDisplay[index].creator == 1) {
      result = await Get.toNamed(AppRouteName.editOccasion,
          arguments: occasionsToDisplay[index]);
    } else {
      result = await Get.toNamed(AppRouteName.occasionDetails,
          arguments: occasionsToDisplay[index]);
    }

    if (result != null) {
      getAppointments();
    }
  }

  // changeNeedApproveValue(bool displayNeedApprove) {
  //   needApprove = displayNeedApprove;

  //   resetAcceptedAndSuspendedList();
  // }

  onTapCreate() async {
    final result = await Get.toNamed(AppRouteName.createOccasion);
    if (result != null) {
      getAppointments();
    }
  }

  String formatDateTime(String inputDateTime) {
    DateTime dateTime = DateTime.parse(inputDateTime);
    String formattedDateTime = DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
    return formattedDateTime;
  }

  // ============= Accept and Reject invitation =============//
  onTapAcceptInvitation(Occasion occasion) async {
    respondToInvitation(occasion, 'accept');

    OccasionNotification.acceptOccasion(occasion.occasionUserid!,
        myServices.getName(), myServices.getImage(), occasion.occasionTitle!);
  }

  onTapRejectInvitation(Occasion occasion) async {
    Get.defaultDialog(
        title: "رفض",
        content: Column(
          children: [
            Text(
              "هل تريد رفض دعوة ${occasion.occasionUsername}؟ ",
              style: titleMedium,
            ),
            const SizedBox(height: 15),
            CustomTextField(
                textEditingController: excuse, hintText: 'ارسال عذر (اختياري)'),
          ],
        ),
        onConfirm: () {
          Get.back();
          respondToInvitation(occasion, 'reject', excuse.text);

          OccasionNotification.rejectOccasion(
              occasion.occasionUserid!,
              myServices.getName(),
              myServices.getImage(),
              occasion.occasionTitle ?? '',
              excuse.text);
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  respondToInvitation(Occasion occasion, String respond,
      [String excuse = '', String message = '']) async {
    CustomDialogs.loading();

    var response;
    if (respond == 'accept') {
      response = await occasionData.responedToInvitation(
          userId: myServices.sharedPreferences.getString("id")!,
          occasionId: occasion.occasionId.toString(),
          respond: '1',
          excuse: '');
    } else {
      response = await occasionData.responedToInvitation(
          userId: myServices.sharedPreferences.getString("id")!,
          occasionId: occasion.occasionId.toString(),
          respond: '2',
          excuse: excuse);
    }
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        if (message != '') {
          CustomDialogs.success(message);
        } else {
          if (respond == 'accept') {
            CustomDialogs.success('تم قبول الدعوة');
          } else {
            CustomDialogs.success('تم رفض الدعوة');
          }
        }

        getAppointments();
      } else {
        CustomDialogs.failure();
      }
    } else {
      CustomDialogs.failure();
    }
  }

  Future getMyOccasion() async {
    var response = await occasionData
        .viewOccasions(myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parsingDataFromJsonToDartList(response);
      }
    }
  }

  parsingDataFromJsonToDartList(response) {
    myOccasions.clear();

    List responseOccasoins = response['data'];
    myOccasions = responseOccasoins.map((e) => Occasion.fromJson(e)).toList();

    //Remove occasions in the past
    myOccasions.removeWhere((element) => isDatePassed(element.occasionDate!));

    resetAcceptedAndSuspendedList();

    setOccasionsToDisplay();
  }

  resetAcceptedAndSuspendedList() {
    occasionsToDisplay.clear();
    acceptedOccasions.clear();
    suspendedOccasions.clear();

    for (var element in myOccasions) {
      if (element.acceptstatus == 1) {
        acceptedOccasions.add(element);
      } else if (element.acceptstatus == 0) {
        suspendedOccasions.add(element);
      }
    }
  }

  setOccasionsToDisplay() {
    occasionsToDisplay.clear();
    if (displayCommingAppt) {
      getArabicDate(selectedDate);
      for (int i = 0; i < acceptedOccasions.length; i++) {
        if (acceptedOccasions[i].occasionDate == selectedDateFormatted) {
          occasionsToDisplay.add(acceptedOccasions[i]);
        }
      }
    } else {
      occasionsToDisplay = List.from(suspendedOccasions);
    }
  }

  getAppointments() async {
    statusRequest = StatusRequest.loading;
    update();
    await Future.wait([getAllRes(), getMyOccasion()]);

    apptNeedApproveNo =
        suspendedOccasions.length + reservationNeedApproval.length;
    update();
  }

  @override
  void onInit() async {
    getAppointments();
    super.onInit();
  }
}
