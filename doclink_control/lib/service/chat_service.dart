import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  void addMessage(String text, String uid, DateTime time) {
    DocumentReference userProfileRef =
        FirebaseFirestore.instance.collection('doctorsprofile').doc(uid);

    CollectionReference messagesCollectionRef =
        userProfileRef.collection('messages');

    messagesCollectionRef.add({
      'text': text,
      'uid': uid,
      'time': time,
    });
  }

  Stream<QuerySnapshot> getMessages() {
    CollectionReference messagesCollectionRef = FirebaseFirestore.instance
        .collection('userprofile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages');
    Query query = messagesCollectionRef.where('doctorId',
        isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    return query.orderBy('time', descending: false).snapshots();
  }
}
