import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/models/prescription_add_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestorePrescriptionService {
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