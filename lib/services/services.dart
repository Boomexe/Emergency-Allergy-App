// import 'dart:convert';

// import 'package:emergency_allergy_app/models/allergy.dart';
// import 'package:emergency_allergy_app/models/medication.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class Services {
//   static FlutterSecureStorage storage = const FlutterSecureStorage();

//   static Future<List<Allergy>> loadAllergies() async {
//     Future<String?> allergiesString = readData('allergies');

//     allergiesString.then((value) {
//       List<Allergy> allergies =
//           Allergy.fromJsonList(jsonDecode(value!)['allergies']);

//       return allergies;
//     });

//     return [];
//   }

//   static void saveAllergy(allergy) async {
//     Future<List<Allergy>> allergies = loadAllergies();

//     allergies.then((value) {
//       value.add(allergy);

//       saveData('allergies', jsonEncode({'allergies': value}));
//     });
//   }

//   static Future<List<Medication>> loadMedications() async {
//     String? medicationsString = await readData('medications');

//     if (medicationsString == null) {
//       return [];
//     }



//     List<Medication> medications =
//         Medication.fromJsonList(jsonDecode(medicationsString)['medications']);

//     return medications;
//   }

//   static void saveMedication(medication) async {
//     List<Medication> medications = await loadMedications();

//     medications.add(medication);
//     saveData('medications', jsonEncode(Medication.toJsonList(medications)));
//   }

//   static Future<List<Medication>> saveAndReturnMedications(medication) async {
//     List<Medication> medications = await loadMedications();

//     medications.add(medication);
//     saveData('medications', jsonEncode(Medication.toJsonList(medications)));
//     return medications;
//   }

//   static void saveData(key, value) async {
//     await storage.write(key: key, value: value);
//   }

//   static Future<String?> readData(key) async {
//     // print(await storage.read(key: key));
//     return await storage.read(key: key);
//   }

//   static void clearData() async {
//     await storage.deleteAll();
//   }
// }
