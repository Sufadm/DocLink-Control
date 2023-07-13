// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatService {
//   // void addMessage(String text, String uid, DateTime time) {
//   //   DocumentReference userProfileRef =
//   //       FirebaseFirestore.instance.collection('doctorsprofile').doc(uid);

//   //   CollectionReference messagesCollectionRef =
//   //       userProfileRef.collection('messages');

//   //   messagesCollectionRef.add({
//   //     'text': text,
//   //     'uid': uid,
//   //     'time': time,
//   //   });
//   // }

//   // Stream<QuerySnapshot> getMessages(String userid) {
//   //   CollectionReference messagesCollectionRef = FirebaseFirestore.instance
//   //       .collection('userprofile')
//   //       .doc(FirebaseAuth.instance.currentUser!.uid)
//   //       .collection('messages');
//   //   Query query = messagesCollectionRef
//   //       .where('doctorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//   //       .where('uid', isEqualTo: userid);

//   //   return query.orderBy('time', descending: false).snapshots();
//   // }
//   // Stream<QuerySnapshot> getMessages(String userid) {
//   //   DocumentReference userProfileRef =
//   //       FirebaseFirestore.instance.collection('userprofile').doc(userid);

//   //   CollectionReference messagesCollectionRef =
//   //       userProfileRef.collection('messages');
//   //   Query query = messagesCollectionRef
//   //       .where('doctorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//   //       .where('uid', isEqualTo: userid);

//   //   return query.orderBy('time', descending: false).snapshots();

//   //   //return messagesCollectionRef.orderBy('time', descending: false).snapshots();
//   // }
//   Stream<QuerySnapshot> getMessages(String userid) {
//     DocumentReference userProfileRef =
//         FirebaseFirestore.instance.collection('userprofile').doc(userid);

//     CollectionReference messagesCollectionRef =
//         userProfileRef.collection('messages');

//     Query query = messagesCollectionRef.where('uid', isEqualTo: userid);

//     return query.orderBy('time', descending: false).snapshots();
//   }
// }

// class ChatService {
//   void addMessage(String text, String uid, DateTime time, String doctorId) {
//     DocumentReference userProfileRef =
//         FirebaseFirestore.instance.collection('userprofile').doc(uid);

//     CollectionReference messagesCollectionRef =
//         userProfileRef.collection('messages');

//     messagesCollectionRef.add({
//       'doctorId': doctorId,
//       'text': text,
//       'uid': uid,
//       'time': time,
//     });
//   }

//   Stream<QuerySnapshot> getMessages(String doctorId) {
//     String currentUserId = FirebaseAuth.instance.currentUser!.uid;

//     DocumentReference userProfileRef =
//         FirebaseFirestore.instance.collection('userprofile').doc(currentUserId);

//     CollectionReference messagesCollectionRef =
//         userProfileRef.collection('messages');

//     Query query = messagesCollectionRef.where('doctorId', isEqualTo: doctorId);
//     // .orderBy('time', descending: false);

//     return query.snapshots();
//   }

//   // Stream<QuerySnapshot> getMessages() {
//   //   String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//   //   DocumentReference userProfileRef =
//   //       FirebaseFirestore.instance.collection('userprofile').doc(currentUserId);

//   //   CollectionReference messagesCollectionRef =
//   //       userProfileRef.collection('messages');

//   //   return messagesCollectionRef.orderBy('time', descending: false).snapshots();
//   // }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_moddel.dart';

class ChatService {
  final CollectionReference doctorCollectionReference =
      FirebaseFirestore.instance.collection("doctorsprofile");

  Future<void> sendTextMessage(
    String senderId,
    String receiverId,
    String message,
  ) async {
    final senderChatCollectionReference =
        doctorCollectionReference.doc(senderId).collection("chats");
    final senderChatDocumentReference =
        senderChatCollectionReference.doc(receiverId);
    await senderChatDocumentReference.set(
      {
        'contactId': senderId,
        'timeSent': DateTime.now(),
      },
    );
    final senderMessagesReference =
        senderChatDocumentReference.collection('messages');
    final senderMessageDocumentReference = senderMessagesReference.doc();
    final senderMessageId = senderMessageDocumentReference.id;

    final senderChatMessage = ChatMessage(
      messageId: senderMessageId,
      senderId: senderId,
      textMessage: message,
      time: Timestamp.now(),
    );

    await senderMessageDocumentReference.set(senderChatMessage.toSnapshot());

    final CollectionReference userCollectionReference =
        FirebaseFirestore.instance.collection("userprofile");

    final receiverChatCollectionReference =
        userCollectionReference.doc(receiverId).collection("chats");
    final receiverChatDocumentReference =
        receiverChatCollectionReference.doc(senderId);
    await receiverChatDocumentReference.set(
      {
        'contactId': receiverId, // Change 'senderId' to 'receiverId'
        'timeSent': DateTime.now(),
      },
    );
    final receiverMessagesReference =
        receiverChatDocumentReference.collection('messages');
    final receiverMessageDocumentReference = receiverMessagesReference.doc();
    final receiverMessageId = receiverMessageDocumentReference.id;

    final receiverChatMessage = ChatMessage(
      messageId: receiverMessageId,
      senderId: senderId,
      textMessage: message,
      time: Timestamp.now(),
    );

    await receiverMessageDocumentReference
        .set(receiverChatMessage.toSnapshot());
  }
}
