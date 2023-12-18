import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatController {
  formatDateTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    String date = DateFormat('dd MMM').format(dateTime);
    String time = DateFormat('hh:mm a').format(dateTime);

    if (dateTime.isBefore(today))
      return date;
    else
      return time;
  }

  getDate(DateTime date) {
    String formatterDate = DateFormat('dd MMM yyyy').format(date);
    return formatterDate;
  }

  getTime(TimeOfDay time) {
    DateTime timeToDate = DateTime(time.hour, time.minute);
    String formattedTime = DateFormat('hh:mm a').format(timeToDate);
    return formattedTime;
  }
}
