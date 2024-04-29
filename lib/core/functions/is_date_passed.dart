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
