import 'package:cloud_firestore/cloud_firestore.dart';

//?adding doctors profile ------------------------------------------------------
class FirestoreService {
  static void saveDetailsToFirestore(
      void Function(String) onSuccess, void Function(String) onError,
      {required String name,
      required String gender,
      required String qualification,
      required String category,
      required String place}) {
    FirebaseFirestore.instance.collection('doctors profile').add({
      'name': name,
      'gender': gender,
      'qualification': qualification,
      'category': category,
      'place': place,
    }).then((DocumentReference document) {
      //? Document added successfully-------------------------------------------
      String documentId = document.id;
      //print('Details saved to Firestore with ID: $documentId');
      onSuccess(documentId); // Call the onSuccess callback with the document ID
    }).catchError((error) {
      // Error occurred while adding document
      // print('Failed to save details to Firestore: $error');
      onError(
          error.toString()); // Call the onError callback with the error message
    });
  }
}
