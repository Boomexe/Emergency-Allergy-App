import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_allergy_app/models/medication.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class FirestoreService {
  static final CollectionReference allergies = db.collection('allergies');
  static final CollectionReference medications = db.collection('medications');

  static Future<DocumentReference<Object?>> addMedication(Medication medication) async {
    return medications.add(Medication.toJson(medication));
  }

  static Future<List<Medication>> getMedications() {
    return medications.get().then(
      (querySnapshot) {
        List<Medication> medicationsList = [];
        for (var docSnapshot in querySnapshot.docs) {
          Medication medication = Medication.fromJson(docSnapshot.data() as Map<String, dynamic>, id: docSnapshot.id);
          medicationsList.add(medication);
        }
        return medicationsList;
      },
      onError: (e) {
        print('Error completing: $e');
        return [];
      },
    );
  }

  // Future<void> updateMedication(Medication medication) async {
  //   return medications.doc(medication.id).update(Medication.toJson(medication));
  // }

  Future<void> deleteMedication(String id) async {
    return medications.doc(id).delete();
  }
}
