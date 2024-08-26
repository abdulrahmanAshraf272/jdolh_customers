import 'package:intl/intl.dart';

String timeInAmPm(String timeIn24) {
  final parts = timeIn24.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);

  final dateTime = DateTime(0, 0, 0, hour, minute);
  final formatter = DateFormat('h:mm a');
  return formatter.format(dateTime);
}
