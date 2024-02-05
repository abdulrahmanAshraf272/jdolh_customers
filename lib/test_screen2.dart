import 'package:auto_size_text/auto_size_text.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/test_screen.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/appt_number_and_date.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class TestScreen2 extends StatefulWidget {
  const TestScreen2({super.key});

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  List<DateTime?> _dates = [DateTime.now()];

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
      appBar: customAppBar(
        title: 'جدولة',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
