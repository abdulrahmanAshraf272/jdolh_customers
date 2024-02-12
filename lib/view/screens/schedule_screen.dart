import 'package:auto_size_text/auto_size_text.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';

import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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
      appBar: customAppBar(
        title: 'جدولة',
      ),
      floatingActionButton: ArraivedCustomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
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
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    //margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        //color: AppColors.gray,
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(20)),
                    child: AutoSizeText(
                      '${getArabicDate(_dates[0]!)}',
                      maxLines: 1,
                      style: headline4,
                    ),
                  ),
                ),
              ),
            ),
            CustomTitle(
              title: 'جدولك القادم',
              bottomPadding: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => AppointmentListItem(onTap: () {
                      Get.toNamed(AppRouteName.apptDetails);
                    })),
            CustomTitle(
              title: 'بحاجة لموافقتك',
              bottomPadding: 10,
              topPadding: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) =>
                    AppointmentListItemNotApproved()),
          ],
        ),
      ),
    );
  }
}

class ArraivedCustomButton extends StatelessWidget {
  const ArraivedCustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 120,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.secondaryColor600),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryColor700),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.secondaryColor),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: AppColors.white,
                      size: 26,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'تسجيل وصول',
                      style: titleSmall2.copyWith(
                          fontSize: 9.sp, color: Colors.white),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
