import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String messageId;
  final String senderId;
  final String textMessage;
  final Timestamp time;

  ChatMessage({
    required this.messageId,
    required this.senderId,
    required this.textMessage,
    required this.time,
  });

  factory ChatMessage.fromSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ChatMessage(
      messageId: data['messageId'],
      senderId: data['senderId'],
      textMessage: data['textMessage'],
      time: data['time'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'textMessage': textMessage,
      'time': time,
    };
  }
}
