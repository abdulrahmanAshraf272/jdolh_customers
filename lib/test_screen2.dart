import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/bill.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_customers/view/widgets/common/flexable_toggle_button.dart';

class TestScreen2 extends StatefulWidget {
  const TestScreen2({super.key});

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  int selectedIndex = 0;
  List<String> list = ['كبير', 'متوسط', 'صغير'];
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
