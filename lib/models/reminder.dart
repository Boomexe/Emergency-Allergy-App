class Reminder {
  final List<String> days;
  final DateTime time;
  bool active = true;

  Reminder({required this.days, required this.time, bool? active});

  static Map<String, dynamic> toJson(Reminder reminder) {
    return {
      'days': reminder.days,
      'time': reminder.time.toString(),
      'active': reminder.active ? 1 : 0,
    };
  }

  static Reminder fromJson(Map<String, dynamic> json) {
    return Reminder(
      days: List<String>.from(json['days']),
      time: DateTime.parse(json['time']),
      active: json['active'] == 1,
    );
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
