class EmergencyContact {
  final String userId;
  final String contactId;

  final String? id;

  EmergencyContact({required this.userId, required this.contactId, this.id});

  factory EmergencyContact.fromJson(Map<String, dynamic> json, {String? id}) {
    return EmergencyContact(
      userId: json['userId'],
      contactId: json['contactId'],
      id: id,
    );
  }

  static Map<String, dynamic> toJson(EmergencyContact emergencyContact) {
    return {
      'userId': emergencyContact.userId,
      'contactId': emergencyContact.contactId,
    };
  }
}
