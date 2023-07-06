import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/models/prescription_add_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestorePrescriptionService {
  // Future<void> addprecription(PrescriptionModel user) async {
  //   try {
  //     final prescriptionCollection =
  //         FirebaseFirestore.instance.collection('precriptions').doc(user.uid);
  //     user.uid = prescriptionCollection.id;
  //     final json = user.toJson();
  //     await prescriptionCollection.set(json);
  //   } catch (error) {
  //     // Error occurred while creating user
  //     // print('Error creating user: $error');
  //     rethrow;
  //   }
  // }

  Future<void> addPrescription(PrescriptionModel prescription) async {
    try {
      final prescriptionCollection =
          FirebaseFirestore.instance.collection('precriptions');
      final json = prescription.toJson();
      await prescriptionCollection.add(json);
    } catch (error) {
      // Error occurred while adding prescription
      // print('Error adding prescription: $error');
      rethrow;
    }
  }

  Stream<List<PrescriptionModel>> getAllPrescriptions(String userId) {
    final prescriptionCollection =
        FirebaseFirestore.instance.collection('precriptions');
    return prescriptionCollection
        .where('id', isEqualTo: userId)
        .where('userId',
            isEqualTo: FirebaseAuth.instance.currentUser
                ?.uid) // Add this line to filter by user ID
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PrescriptionModel.fromJson(doc.data()))
            .toList());
  }
}
















//   Stream<List<PrescriptionModel>> getAllPrescriptions() {
//     final prescriptionCollection =
//         FirebaseFirestore.instance.collection('precriptions');
//     return prescriptionCollection.snapshots().map((snapshot) => snapshot.docs
//         .map((doc) => PrescriptionModel.fromJson(doc.data()))
//         .toList());
//   }
// }