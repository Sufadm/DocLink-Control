import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/models/prescription_add_model.dart';

class FirestorePrescriptionService {
  Future<void> addprecription(PrescriptionModel user) async {
    try {
      final prescriptionCollection =
          FirebaseFirestore.instance.collection('precriptions').doc(user.uid);
      user.uid = prescriptionCollection.id;
      final json = user.toJson();
      await prescriptionCollection.set(json);
    } catch (error) {
      // Error occurred while creating user
      // print('Error creating user: $error');
      rethrow;
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

  Stream<List<PrescriptionModel>> getAllPrescriptions(String userId) {
    final prescriptionCollection =
        FirebaseFirestore.instance.collection('precriptions');
    return prescriptionCollection
        .where('id', isEqualTo: userId) // Add this line to filter by user ID
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PrescriptionModel.fromJson(doc.data()))
            .toList());
  }
}
