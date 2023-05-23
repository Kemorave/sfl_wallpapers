class DateUtil {
  static String dateDifferance(String date) {
    return DateTime.now()
        .difference(DateTime.parse(date.split('T')[0]))
        .inDays
        .toString();
  }
}
