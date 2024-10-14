import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_allergy_app/models/allergy.dart';
import 'package:emergency_allergy_app/models/emergency_contact.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class FirestoreService {
  static final CollectionReference allergies = db.collection('allergies');
  static final CollectionReference medications = db.collection('medications');
  static final CollectionReference emergencyContacts = db.collection('emergencyContacts');

  static Future<DocumentReference<Object?>> addEmergencyContact(
      EmergencyContact emergencyContact) async {
    return emergencyContacts.add(EmergencyContact.toJson(emergencyContact));
  }

  static Future<List<Medication>> getMedications() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('No user logged in');
      return Future.value([]);
    }

    // TODO: FIX ERROR THAT USER ISN'T SIGNED IN
    return medications.where('userId', isEqualTo: user.uid).get().then(
      (querySnapshot) {
        List<Medication> medicationsList = [];
        for (var docSnapshot in querySnapshot.docs) {
          Medication medication = Medication.fromJson(
              docSnapshot.data() as Map<String, dynamic>,
              id: docSnapshot.id);
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

  static Future<List<Medication>> getMedicationsFromIds(
      List<String> ids) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('No user logged in');
      return [];
    }

    List<Medication> medicationsList = [];
    try {
      // Break the IDs into chunks of 10
      for (int i = 0; i < ids.length; i += 10) {
        List<String> idsChunk =
            ids.sublist(i, i + 10 > ids.length ? ids.length : i + 10);

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('medications')
            .where(FieldPath.documentId, whereIn: idsChunk)
            .where('userId', isEqualTo: user.uid)
            .get();

        List<Medication> chunkMedicationsList =
            querySnapshot.docs.map((docSnapshot) {
          return Medication.fromJson(docSnapshot.data() as Map<String, dynamic>,
              id: docSnapshot.id);
        }).toList();

        medicationsList.addAll(chunkMedicationsList);
      }

      return medicationsList;
    } catch (e) {
      print('Error completing: $e');
      return [];
    }
  }

  static Future<Medication>? getMedication(String id) {
    return medications.doc(id).get().then(
      (docSnapshot) {
        Medication medication = Medication.fromJson(
            docSnapshot.data() as Map<String, dynamic>,
            id: docSnapshot.id);
        return medication;
      },
      onError: (e) {
        print('Error completing: $e');
        return null;
      },
    );
  }

  static Future<DocumentReference<Object?>> addMedication(
      Medication medication) async {
    return medications.add(Medication.toJson(medication));
  }

  static Future<void> updateMedication(String id, Medication medication) async {
    return medications.doc(id).update(Medication.toJson(medication));
  }

  static Future<void> deleteMedication(String id) async {
    return medications.doc(id).delete();
  }

  static Future<List<Allergy>> getAllergies() {
    User? user = FirebaseAuth.instance.currentUser;

    return allergies.where('userId', isEqualTo: user!.uid).get().then(
      (querySnapshot) {
        List<Allergy> allergiesList = [];
        for (var docSnapshot in querySnapshot.docs) {
          Allergy allergy = Allergy.fromJson(
              docSnapshot.data() as Map<String, dynamic>,
              id: docSnapshot.id);
          allergiesList.add(allergy);
        }

        return allergiesList;
      },
      onError: (e) {
        print('Error completing: $e');
        return [];
      },
    );
  }

  static Future<DocumentReference<Object?>> addAllergy(Allergy allergy) async {
    return allergies.add(Allergy.toJson(allergy));
  }

  static Future<void> updateAllergy(String id, Allergy allergy) async {
    return allergies.doc(id).update(Allergy.toJson(allergy));
  }

  static Future<void> deleteAllergy(String id) async {
    return allergies.doc(id).delete();
  }
}
