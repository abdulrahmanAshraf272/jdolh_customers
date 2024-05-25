bool isDatePassed(String dateString) {
  // Parse the string into a DateTime object
  List<String> dateParts = dateString.split('-');
  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2]);

  DateTime date = DateTime(year, month, day);

  // Get the current date
  DateTime currentDate = DateTime.now();

  if (date.year == currentDate.year &&
      date.month == currentDate.month &&
      date.day == currentDate.day) {
    return false;
  }

  // Compare the given date with the current date
  return date.isBefore(currentDate);
}

bool isDateTimePassed(String dateTimeString) {
  // Parse the string into a DateTime object
  DateTime dateTime = parseDateTime(dateTimeString);

  // Get the current date and time
  DateTime currentDateTime = DateTime.now();

  // Compare the given datetime with the current datetime
  return dateTime.isBefore(currentDateTime);
}

// Function to parse datetime string
DateTime parseDateTime(String dateTimeString) {
  // Split the string into date and time parts
  List<String> parts = dateTimeString.split(' ');
  List<String> dateParts = parts[0].split('-');
  List<String> timeParts = parts[1].split(':');

  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2]);
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  return DateTime(year, month, day, hour, minute);
}
