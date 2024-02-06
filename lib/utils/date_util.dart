import 'package:intl/intl.dart';
class WdDateUtil {
  static String format(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String getCurrentDate() {
    DateTime now = DateTime.now();
    return format(now);
  }
}