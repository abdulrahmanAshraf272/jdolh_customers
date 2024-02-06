import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class ReservationDoneScreen extends StatelessWidget {
  const ReservationDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'الفواتير'),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.05),
          Center(
              child:
                  Icon(Icons.check_circle, size: 100.w, color: Colors.green)),
          Text('تهانينا, تم تأكيد الحجز', style: headline4),
          const SizedBox(height: 10),
          Text(
            'شكرا لاختيارك جدولة',
            style:
                TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
          ),
          const SizedBox(height: 10),
          Divider(
            indent: 30,
            endIndent: 30,
          ),
          Text('مطعم البيك',
              style:
                  TextStyle(fontSize: (17.5).sp, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(
            'الرياض, شارع الصحابة',
            style:
                TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
          ),
          SizedBox(height: 10),
          DateOrLocationDisplayContainer(
            hintText: 'وقت الحجز 2022/5/15 4:00',
            iconData: Icons.date_range,
            iconEnd: false,
            verticalMargin: 5,
          ),
          DateOrLocationDisplayContainer(
            hintText: 'رقم الحجز: 2123',
            iconData: Icons.save,
            iconEnd: false,
          ),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: DateOrLocationDisplayContainer(
                  hintText: 'مشاركة عنوان الحجز',
                  iconData: Icons.share,
                  iconEnd: false,
                  horizontalMargin: 0,
                  onTap: () {},
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: DateOrLocationDisplayContainer(
                  hintText: 'عرض على الخريطة',
                  iconData: Icons.pin_drop_outlined,
                  iconEnd: false,
                  horizontalMargin: 0,
                  onTap: () {},
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 40),
          GoHomeButton(
            onTap: () {},
          )
        ],
      ),
    );
  }
}
