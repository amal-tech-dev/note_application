import 'package:intl/intl.dart';

class DateTimeFormatController {
  String formatDateTime(DateTime dateTime) {
    String date = DateFormat('yy MMM').format(dateTime);
    String time = DateFormat('hh:mm a').format(dateTime);

    if (dateTime.isBefore(DateTime.now().subtract(Duration(days: 2))))
      return '$date $time';
    else if (dateTime
        .isBefore(DateTime.now().subtract(const Duration(days: 1))))
      return 'Yesterday $time';
    else
      return time;
  }
}
