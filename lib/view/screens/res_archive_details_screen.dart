import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/schedule/reservation_details_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/activity_notification.dart';
import 'package:jdolh_customers/data/data_source/remote/rate.dart';
import 'package:jdolh_customers/data/models/rate.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bill_datails.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/cart_product.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/cart_service.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bch_and_reservation_data.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/reservation_date.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ResArchiveDetailsScreen extends StatefulWidget {
  const ResArchiveDetailsScreen({super.key});

  @override
  State<ResArchiveDetailsScreen> createState() =>
      _ResArchiveDetailsScreenState();
}

class _ResArchiveDetailsScreenState extends State<ResArchiveDetailsScreen> {
  StatusRequest statusRequest = StatusRequest.none;
  RateData rateData = RateData(Get.find());
  late ReservationDetailsController controller;
  late Reservation reservation;
  bool? finished;
  Rate? rate;

  addRate(double rateValue, String comment) async {
    var response = await rateData.addRate(
        userid: reservation.resUserid.toString(),
        brandid: reservation.resBrandid.toString(),
        bchid: reservation.resBchid.toString(),
        ratevalue: rateValue.toString(),
        comment: comment.toString(),
        resid: reservation.resId.toString());
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        rate = Rate.fromJson(response['data']);

        ActivityNotification activityNotification = ActivityNotification();
        activityNotification.sendRateActivityToFollowers(
            reservation.bchid!,
            reservation.brandName!,
            reservation.bchCity!,
            reservation.brandLogo!,
            rateValue);
        activityNotification.sendRateToBch(
            reservation.resBchid!, reservation.bchCity!, rateValue);

        print('rate: ${rate!.rateComment}');
        setState(() {});
      } else {
        print('failure');
      }
    }
  }

  deleteRate() async {
    if (rate == null) {
      return;
    }
    String rateid = rate!.rateId.toString();
    rate = null;
    setState(() {});
    var response = await rateData.deleteRate(rateid: rateid);
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('delete success');
      } else {
        print('failure');
      }
    }
  }

  getRate() async {
    var response = await rateData.getRate(resid: reservation.resId.toString());
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        rate = Rate.fromJson(response['data']);
        print('rate: ${rate!.rateComment}');
        setState(() {});
        return true;
      } else {
        print('failure');
      }
    }

    return false;
  }

  // show the dialog
  displayRate(String logo, Function(RatingDialogResponse) onSubmitted) {
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => RatingDialog(
        initialRating: 5.0,
        // your app's name?
        title: Text(
          'تقييم الحجز'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        // encourage your user to leave a high rating?
        message: Text(
          'يمكنك تقييم الحجز واضافة تعليق عن تجربك'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
        // your app's logo?
        image: BrandLogo(
          brandLogo: logo,
        ),
        submitButtonText: 'تقييم'.tr,
        commentHint: 'اضف رايك في المكان'.tr,
        onSubmitted: onSubmitted,
      ),
    );
  }

  checkRateExist() async {
    bool rateExist = await getRate();
    if (rateExist == false) {
      displayRate('${ApiLinks.logoImage}/${controller.reservation.brandLogo!}',
          (result) => {addRate(result.rating, result.comment)});
    }
  }

  @override
  void initState() {
    controller = Get.put(ReservationDetailsController());
    reservation = Get.arguments['res'];
    if (Get.arguments['finished'] != null) {
      bool finished = Get.arguments['finished'];
      print(finished);
      if (finished == true) {
        checkRateExist();
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationDetailsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(
                  title:
                      '${'تفاصيل الحجز رقم:'.tr} #${controller.reservation.resId}'),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const BchDataHeader(),
                    if (rate != null)
                      RatingCommentWidget(
                        rate: rate!,
                        onTapDelete: () {
                          deleteRate();
                        },
                      ),
                    const BchLocation(),
                    const ContactNumber(),
                    const SizedBox(height: 5),
                    ReservationDate(
                        date: controller.reservation.resDate ?? '',
                        time: controller.resTime),
                    const SizedBox(height: 5),
                    ReservationData(
                      date: '${controller.reservation.resDate}',
                      time: controller.resTime,
                      resOption: controller.reservation.resResOption ?? '',
                      duration: controller.reservation.resDuration.toString(),
                    ),
                    const SizedBox(height: 20),
                    const ResCartData(),
                    const SizedBox(height: 20),
                    const BillDetails(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ));
  }
}

class RatingCommentWidget extends StatelessWidget {
  final Rate rate;
  final void Function() onTapDelete;

  const RatingCommentWidget(
      {Key? key, required this.rate, required this.onTapDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: rate.rateRatevalue ?? 5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // You can handle rating update here if needed
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      rate.rateRatevalue.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  rate.rateComment ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: onTapDelete,
              child: Text(
                'حذف'.tr,
                style: const TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
  }
}

class ResCartData extends StatelessWidget {
  const ResCartData({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationDetailsController());
    return controller.isService
        ? Column(
            children: [
              CustomTitle(title: 'الخدمات'.tr),
              const CartService(),
            ],
          )
        : Column(
            children: [
              CustomTitle(title: 'تفاصيل الطلب'.tr),
              const SizedBox(height: 15),
              const OrderContentTitle(),
              const CartProduct(),
            ],
          );
  }
}

class BrandLogo extends StatelessWidget {
  final String? brandLogo;

  const BrandLogo({Key? key, this.brandLogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: brandLogo != null
          ? FadeInImage.assetNetwork(
              width: 80,
              height: 80,
              placeholder: 'assets/images/loading2.gif',
              image: brandLogo!,
              //fit: BoxFit.cover,
            )
          : Image.asset(
              'assets/images/noImageAvailable.jpg',
              // fit: BoxFit.cover,
            ),
    );
  }
}
