class EmergencyNumber {
  final String userId;
  final String name;
  final String phoneNumber;

  EmergencyNumber(
      {required this.userId, required this.name, required this.phoneNumber});

  factory EmergencyNumber.fromJson(Map<String, dynamic> json, {String? id}) {
    return EmergencyNumber(
      name: json['name'],
      phoneNumber: json['phone'],
      userId: json['userId'],
    );
  }

  static Map<String, dynamic> toJson(EmergencyNumber contact) {
    return {
      'name': contact.name,
      'phone': contact.phoneNumber,
      'userId': contact.userId,
    };
  }
}
