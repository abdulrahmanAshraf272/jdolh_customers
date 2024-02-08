import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';

class DescAndBranshedButtonAndWorkTime extends StatelessWidget {
  const DescAndBranshedButtonAndWorkTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Row(
          children: [
            Expanded(child: AutoSizeText('مواعيد العمل: 9:00 ص - 12:00 ص')),
            SizedBox(
                width: 120.w,
                child: CustomDropdownButton(
                  buttonHeight: 28,
                ))
          ],
        ),
        SizedBox(height: 10),
        AutoSizeText(
          'بيتزا هت هو أحد سلاسل مطاعم الوجبات السريعة الأمريكية وله فروع في العديد من الدول حول العالم. يختص بوجبات البيتزا بأنواعها، الا انه يقدم وجبات أخرى. كما انه يقدم خدمة توصيل الطلبات الخارجية إضافة إلى إمكانية الأكل في المطعم.',
          maxLines: 4,
        )
      ]),
    );
  }
}
