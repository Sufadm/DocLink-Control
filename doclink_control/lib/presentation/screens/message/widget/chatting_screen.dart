import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../models/chat_moddel.dart';
import '../../../../service/chat_service.dart';
import '../../../../shared/const/const.dart';

class ChattingScreen extends StatelessWidget {
  final chatController = TextEditingController();
  final String image;
  final String name;
  final String gender;
  final String userid;

  ChattingScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.gender,
    required this.userid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentuserid = FirebaseAuth.instance.currentUser!.uid;

    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: kDarkBlueButtonsColor,
        leading: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
          ],
        ),
        title: Container(
          margin: const EdgeInsets.only(left: 30),
          child: Text(
            name,
            style: GoogleFonts.outfit(),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('doctorsprofile')
                    .doc(currentuserid)
                    .collection('chats')
                    .doc(userid)
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs
                        .map((doc) => ChatMessage.fromSnapshot(doc))
                        .toList();
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        // final reversedIndex = messages.length - 1 - index;
                        final message = messages[index];
                        // final uid = message['doctorId'];
                        // final time = message['time'].toDate();

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 8,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: message.senderId == currentuserid
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: const Radius.circular(20),
                                    topRight: const Radius.circular(20),
                                    bottomRight: Radius.circular(
                                        message.senderId ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? 0
                                            : 20),
                                    topLeft: Radius.circular(message.senderId ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? 20
                                        : 0),
                                  ),
                                  color: message.senderId == currentuserid
                                      ? Colors.grey.shade800
                                      : const Color.fromARGB(255, 78, 77, 77)
                                          .withOpacity(0.6),
                                ),
                                constraints:
                                    BoxConstraints(maxWidth: w * 2 / 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 30),
                                      child: Text(
                                        message.textMessage,
                                        style: GoogleFonts.outfit(
                                          color: kWhiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateFormat.jm()
                                          .format((message.time.toDate()))
                                          .toString(),
                                      style: GoogleFonts.lato(
                                          fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: chatController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter a Message',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: GoogleFonts.outfit(color: kWhiteColor),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // sendMessage();
                      ChatService().sendTextMessage(
                          currentuserid, userid, chatController.text.trim());
                      chatController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 30,
                      color: kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget giveTime(DateTime dateTime) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        DateFormat('kk:mm').format(dateTime),
        style: GoogleFonts.outfit(color: Colors.grey.shade600, fontSize: 10),
      ),
    );
  }

  // void sendMessage() {
  //   String messageText = chatController.text.trim();
  //   if (messageText.isNotEmpty) {
  //     ChatService().addMessage(
  //       messageText,
  //       FirebaseAuth
  //           .instance.currentUser!.uid, // Replace with the actual user ID
  //       DateTime.now(),
  //     );
  //     chatController.clear();
  //   }
  // }
}
