import 'package:emergency_allergy_app/utils/reminder_utils.dart';
import 'package:flutter/material.dart';

class Reminder {
  final List<String> days;
  final TimeOfDay time;
  final bool active;

  Reminder({required this.days, required this.time, required this.active});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      days: List<String>.from(json['days']),
      time: ReminderUtils.parseTimeOfDay(json['time']),
      active: json['active'],
    );
  }

  static List<Reminder> fromJsonList(List<dynamic> jsonList) {
    List<Reminder> reminders = [];
    for (var json in jsonList) {
      reminders.add(Reminder.fromJson(json));
    }

    return reminders;
  }

  static Map<String, dynamic> toJson(Reminder reminder) {
    return {
      'days': reminder.days,
      'time': ReminderUtils.timeOfDayToString(reminder.time),
      'active': reminder.active,
    };
  }

  static List<Map<String, dynamic>> toJsonList(List<Reminder> reminders) {
    List<Map<String, dynamic>> jsonList = [];
    for (Reminder reminder in reminders) {
      jsonList.add(Reminder.toJson(reminder));
    }

    return jsonList;
  }
}
