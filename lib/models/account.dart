// import 'package:emergency_allergy_app/models/allergy.dart';

class Account {
  String firstName;
  String lastName;

  DateTime birthDate;
  int weightInLbs;
  int heightInInches;

  Account({required this.firstName, required this.lastName, required this.birthDate, required this.weightInLbs, required this.heightInInches});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      weightInLbs: json['weightInLbs'],
      heightInInches: json['heightInInches'],
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'birthDate': birthDate,
    'weightInLbs': weightInLbs,
    'heightInInches': heightInInches,
  };

  Duration getAge() {
    return DateTime.now().difference(birthDate);
  }
}