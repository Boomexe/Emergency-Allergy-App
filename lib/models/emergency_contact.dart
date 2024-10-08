class EmergencyContact {
  final String userId;
  final String name;
  final String phoneNumber;

  EmergencyContact(
      {required this.userId, required this.name, required this.phoneNumber});

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'],
      phoneNumber: json['phone'],
      userId: json['userId'],
    );
  }

  static Map<String, dynamic> toJson(EmergencyContact contact) {
    return {
      'name': contact.name,
      'phone': contact.phoneNumber,
      'userId': contact.userId,
    };
  }
}
