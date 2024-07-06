String convertTimeToArabic(String? time) {
  if (time == null) {
    return '';
  }
  // Split the time string into hours and minutes
  List<String> parts = time.split(':');
  int hour = int.parse(parts[0]);
  String minutes = parts[1];

  // Determine if it's AM or PM
  String period = hour >= 12 ? 'م' : 'ص';

  // Convert to 12-hour format
  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12;
  }

  // Return the formatted time string
  return '$hour:$minutes $period';
}
