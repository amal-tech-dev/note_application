import 'package:flutter/material.dart';

class DateController {
  late DateTime date;
  late TimeOfDay time;
  late DateTime today;
  late String year, month, day, hour, minute, dateText, timeText, finalDate;
  DateTime now = DateTime.now();

  // fliter date and time from given date
  filterDate(DateTime dateTime) {
    date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    today = DateTime(now.year, now.month, now.day);

    year = date.year.toString();
    month = date.month.toString().padLeft(2, '0');
    day = date.day.toString().padLeft(2, '0');
    hour = time.hour.toString().padLeft(2, '0');
    minute = time.minute.toString().padLeft(2, '0');

    dateText = '$day-$month-$year';
    timeText = '$hour:$minute';
    finalDate = '$day-$month-$year $hour:$minute';
  }

  // get date
  getTaskDate(DateTime dateTime) {
    filterDate(dateTime);
    return finalDate;
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
