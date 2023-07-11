import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/models/adddetail_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreAddDetailService {
  final CollectionReference adddetailCollection =
      FirebaseFirestore.instance.collection('adddetails');
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllDetailsStream(
      String doctorId) {
    return adddetailCollection
        .where('uid', isEqualTo: doctorId)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot as QuerySnapshot<Map<String, dynamic>>);
  }

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

  Future<void> deleteDetail(String detailId) async {
    try {
      await adddetailCollection.doc(detailId).delete();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateDetail(
      String detailId, Map<String, dynamic> updatedData) async {
    try {
      await adddetailCollection.doc(detailId).update(updatedData);
    } catch (error) {
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDetailsStream(
      String doctorId) {
    final currentUserId = getCurrentUserId();
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
