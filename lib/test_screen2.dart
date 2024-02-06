import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class TestScreen2 extends StatefulWidget {
  const TestScreen2({super.key});

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  List<DateTime?> _dates = [DateTime.now()];
  //TODO: Refactor this code to be Clean code , and able to use it any where any time
  String getArabicDate(DateTime dateTime) {
    // Create a DateFormat object with the desired format and locale.
    //final formatter = DateFormat('EEEE, dd MMMM, yyyy', 'ar');
    final formatter = DateFormat('EEEE, dd MMMM, yyyy', 'ar');
    // Format the date using the DateFormat object.
    final formattedDate = formatter.format(dateTime);

    final dayName = DateFormat('EEEE', 'ar');
    final month = DateFormat('MMMM', 'ar');
    final day = DateFormat('dd');
    final year = DateFormat('yyyy');

    final dayNameFormat = dayName.format(dateTime);
    final monthFormat = month.format(dateTime);
    final dayFormat = day.format(dateTime);
    final yearFormat = year.format(dateTime);

    print("$dayNameFormat, $dayFormat $monthFormat, $yearFormat");

    final date = "$dayNameFormat, $dayFormat $monthFormat, $yearFormat";

    //String modifiedDate =formattedDate.replaceAll(RegExp('٠١٢٣٤٥٦٧٨٩'), '0123456789');

    return date;

    // Return the formatted date.
    //return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'وقت الحجز'),
      body: Column(
        children: [
          CustomSmallTitle(
            title: 'اختر التاريخ',
            topPadding: 20,
            leftPadding: 20,
            rightPdding: 20,
          ),
          CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.single,
            ),
            value: _dates,
            onValueChanged: (dates) {
              _dates = dates;
              print(_dates[0]!.format(AmericanDateFormats.dayOfWeek));
              print(_dates[0]!.format('l'));
              print(_dates[0]!.format('F'));
              //print(DateTimeFormat.format(_dates[0]!,format: AmericanDateFormats.dayOfWeek));
              setState(() {});
              // final formatter = DateFormat('EEEE', 'ar');
              // final arabicDate = formatter.format(_dates[0]!);
              // print(arabicDate);

              print(getArabicDate(_dates[0]!));
            },
          )
        ],
      ),
    );
  }
}
