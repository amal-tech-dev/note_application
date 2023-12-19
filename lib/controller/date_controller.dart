import 'package:flutter/material.dart';

class DateController {
  late DateTime date;
  late TimeOfDay time;
  late DateTime today;
  late String year, month, day, hour, minute, dateText, timeText;
  DateTime now = DateTime.now();

  // fliter date and time from given date
  filterDate(DateTime dateTime) {
    date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    today = DateTime(now.year, now.month, now.day);

    year = '${date.year}';

    if (date.month < 10) {
      month = '0${date.month}';
    } else {
      month = '${date.month}';
    }

    if (date.day < 10) {
      day = '0${date.day}';
    } else {
      day = '${date.day}';
    }

    if (time.hour < 10) {
      hour = '0${time.hour}';
    } else {
      hour = '${time.hour}';
    }

    if (time.minute < 10) {
      minute = '0${time.minute}';
    } else {
      minute = '${time.minute}';
    }

    dateText = '$day-$month-$year';
    timeText = '$hour:$minute';
  }

  // check date is before today
  getTaskDate(DateTime dateTime) {
    filterDate(dateTime);
    if (dateTime.isBefore(today)) {
      return dateText;
    } else {
      return timeText;
    }
  }

  // set date
  setDate(DateTime dateTime) {
    date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    filterDate(dateTime);
  }

// set time
  setTime(DateTime dateTime) {
    time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    filterDate(dateTime);
  }
}
