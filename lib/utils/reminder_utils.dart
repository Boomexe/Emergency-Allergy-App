import 'package:emergency_allergy_app/models/reminder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReminderUtils {
  static const days = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
  ];

  static const Map<String, String> dayAbbreviations = {
    'sunday': 'Sun',
    'monday': 'Mon',
    'tuesday': 'Tue',
    'wednesday': 'Wed',
    'thursday': 'Thu',
    'friday': 'Fri',
    'saturday': 'Sat',
  };

  static const Map<String, String> dayInitials = {
    'sunday': 'S',
    'monday': 'M',
    'tuesday': 'T',
    'wednesday': 'W',
    'thursday': 'T',
    'friday': 'F',
    'saturday': 'S',
  };

  static String getAbbreviatedDayName(String dayName) {
    return dayAbbreviations[dayName] ?? dayName;
  }

  static String getDayNameInitial(String dayName) {
    return dayAbbreviations[dayName] ?? dayName;
  }

  static List<String> getWeekends() {
    return [days[0], days[6]];
  }

  static List<String> getWeekdays() {
    return [days[1], days[2], days[3], days[4], days[5]];
  }

  static String timeOfDayToString(TimeOfDay time, {bool usePeriod = true}) {
    String minute = time.minute.toString().length > 1 ? time.minute.toString() : '0${time.minute}';

    if (usePeriod) {
      String period = time.hour > 12 ? 'PM' : 'AM';
      int hour = time.hour > 12 ? time.hour - 12 : time.hour;
      hour = time.hour == 0 ? 12 : time.hour;
      return '$hour:$minute $period';
    }

    String hour = time.hour.toString();
    return '$hour:$minute';
  }

  static String timeOfDayPeriodOnly(TimeOfDay time) {
    return time.hour > 12 ? 'PM' : 'AM';
  }

  static String timeOfDayPeriodString(TimeOfDay time) {
    String minute = time.minute.toString().length > 1 ? time.minute.toString() : '0${time.minute}';
    int hour = time.hour > 12 ? time.hour - 12 : time.hour;
    hour = time.hour == 0 ? 12 : hour;
    return '$hour:$minute';
  }

  static TimeOfDay parseTimeOfDay(String time) {
    List<String> timeParts = time.split(':');
    return TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
  }

  static String getSelectedDayString(List<String> days) {    
    List<String> selectedDayAbbreviaitons = days
        .map((e) => ReminderUtils.getAbbreviatedDayName(e))
        .toList();

    List<String> orderedSelectedDays = days;
    List<String> orderedWeekends = ReminderUtils.getWeekends();
    List<String> orderedWeekdays = ReminderUtils.getWeekdays();

    orderedSelectedDays.sort();
    orderedWeekends.sort();
    orderedWeekdays.sort();

    if (days.length == 7) {
      return 'Every day';
    }

    if (days.isEmpty) {
      return 'Never repeats';
    }

    if (listEquals(orderedSelectedDays, orderedWeekends)) {
      return 'Weekends';
    }

    if (listEquals(orderedSelectedDays, orderedWeekdays)) {
      return 'Weekdays';
    }

    if (days.length == 1) {
      return 'Every ${selectedDayAbbreviaitons[0]}';
    }

    if (days.length == 2) {
      return 'Every ${selectedDayAbbreviaitons[0]} and ${selectedDayAbbreviaitons[1]}';
    }

    return 'Every ${selectedDayAbbreviaitons.sublist(0, selectedDayAbbreviaitons.length - 1).join(', ')}, and ${selectedDayAbbreviaitons.last}';
  }
}
