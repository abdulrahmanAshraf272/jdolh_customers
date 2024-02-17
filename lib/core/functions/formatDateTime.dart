import 'package:intl/intl.dart';

String formatDateTime(String inputDateTime) {
  DateTime dateTime = DateTime.parse(inputDateTime);
  String formattedDateTime = DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
  return formattedDateTime;
}
