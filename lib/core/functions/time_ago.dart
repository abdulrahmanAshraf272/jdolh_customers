String timeAgo(String timestamp, [String lang = 'ar']) {
  final DateTime dateTime = DateTime.parse(timestamp);
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  String yearString = 'سنة';
  String agoString = 'منذ';
  String monthString = 'شهر';
  String weekString = 'اسبوع';
  String dayString = 'يوم';
  String hourString = 'ساعة';
  String minString = 'دقيقة';
  String nowString = 'الآن';

  String yearStringP = 'سنوات';
  String monthStringP = 'اشهر';
  String weekStringP = 'اسابيع';
  String dayStringP = 'ايام';
  String hourStringP = 'ساعات';
  String minStringP = 'دقائق';

  if (lang == 'en') {
    yearString = 'year';
    agoString = 'ago';
    monthString = 'month';
    weekString = 'week';
    dayString = 'day';
    hourString = 'hour';
    minString = 'minute';
    nowString = 'just now';

    yearStringP = 'years';
    monthStringP = 'months';
    weekStringP = 'weeks';
    dayStringP = 'days';
    hourStringP = 'hours';
    minStringP = 'minutes';
  }

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$agoString $years ${years == 1 ? yearString : yearStringP}';
  } else if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return '$agoString $months ${months == 1 ? monthString : monthStringP}';
  } else if (difference.inDays >= 7) {
    final weeks = (difference.inDays / 7).floor();
    return '$agoString $weeks ${weeks == 1 ? weekString : weekStringP}';
  } else if (difference.inDays > 0) {
    return '$agoString ${difference.inDays} ${difference.inDays == 1 ? dayString : dayStringP} ';
  } else if (difference.inHours > 0) {
    return ' $agoString ${difference.inHours} ${difference.inHours == 1 ? hourString : hourStringP}';
  } else if (difference.inMinutes > 0) {
    return '$agoString ${difference.inMinutes} ${difference.inMinutes == 1 ? minString : minStringP}';
  } else {
    return nowString;
  }
}
