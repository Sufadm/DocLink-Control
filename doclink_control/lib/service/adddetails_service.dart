import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/models/adddetail_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreAddDetailService {
  final CollectionReference adddetailCollection =
      FirebaseFirestore.instance.collection('adddetails');

  Future<void> addDetailService(AddDetailModel user) async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('adddetails').doc(user.uid);
      user.uid = docUser.id;
      final json = user.toJson();
      await docUser.set(json);
    } catch (error) {
      // Error occurred while creating user
      // print('Error creating user: $error');
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDetailsStream() {
    final currentUserId =
        getCurrentUserId(); // Replace with your logic to get the currently logged-in user's ID
    final profileStream = FirebaseFirestore.instance
        .collection('adddetails')
        .doc(currentUserId)
        .snapshots();

    return profileStream;
  }

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }
}
