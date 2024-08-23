class Reminder {
  final List<String> days;
  final DateTime time;
  bool active = true;

  Reminder({required this.days, required this.time, bool? active});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      days: List<String>.from(json['days']),
      time: DateTime.parse(json['time']),
      active: json['active'] == 1,
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
      'time': reminder.time.toIso8601String(),
      'active': reminder.active ? 1 : 0,
    };
  }




  static List<Map<String, dynamic>> toJsonList(List<Reminder> reminders) {
    List<Map<String, dynamic>> jsonList = [];
    for (Reminder reminder in reminders) {
      jsonList.add(Reminder.toJson(reminder));
    }

    return jsonList;
  }

  void setUnactive() {
    active = false;
  }

  void setActive() {
    active = true;
  }

  bool isActive() {
    return active;
  }
}
