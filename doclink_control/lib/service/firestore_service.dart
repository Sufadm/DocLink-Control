import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/models/profilemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

//?adding doctors profile ------------------------------------------------------
final currentuserId = FirebaseAuth.instance.currentUser!.uid;

class FirestoreService {
  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('doctorsprofile');

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$filename');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      // Handle the error appropriately
      rethrow;
    }
  }

  Future<String> updateImageToStorage(String uid, File imageFile) async {
    try {
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$uid/$filename');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      // Handle the error appropriately
      rethrow;
    }
  }

//?creating and storing doc details to firetore---------------------------------

  Future<void> createUser(ProfileModel user) async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('doctorsprofile').doc(user.uid);
      user.uid = docUser.id;
      final json = user.toJson();
      await docUser.set(json);
    } catch (error) {
      // Error occurred while creating user
      // print('Error creating user: $error');
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileStream() {
    final currentUserId =
        getCurrentUserId(); // Replace with your logic to get the currently logged-in user's ID
    final profileStream = FirebaseFirestore.instance
        .collection('doctorsprofile')
        .doc(currentUserId)
        .snapshots();

    return profileStream;
  }

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  //?update Doctors Profile-----------------------------------------------------
  Future<void> updateUser(ProfileModel user) async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('doctorsprofile').doc(user.uid);
      final json = user.toJson();
      await docUser.update(json);
    } catch (error) {
      // Error occurred while updating user
      // print('Error updating user: $error');
      rethrow;
    }
  }
}
