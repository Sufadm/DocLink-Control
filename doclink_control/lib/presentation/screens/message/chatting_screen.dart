import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:doclink_control/presentation/screens/message/widget/textform_message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/chat_moddel.dart';
import '../../../service/chat_service.dart';
import '../../../shared/const/const.dart';

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
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs
                        .map((doc) => ChatMessage.fromSnapshot(doc))
                        .toList();
                    final groupedMessages = groupBy(
                      messages,
                      (message) => DateFormat("dd MMM yyyy")
                          .format(message.time.toDate()),
                    );

                    return ListView.builder(
                      reverse: false,
                      itemCount: groupedMessages.length,
                      itemBuilder: (context, index) {
                        final date = groupedMessages.keys.elementAt(index);
                        final messagesForDate =
                            groupedMessages.values.elementAt(index);
                        final dateCard = Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              date,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                // color: Colors.white
                              ),
                            ),
                          ),
                        );
                        return Column(
                          children: [
                            dateCard,
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: messagesForDate.length,
                              itemBuilder: (context, index) {
                                final message = messagesForDate[index];
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
                                    mainAxisAlignment:
                                        message.senderId == currentuserid
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
                                            bottomLeft:
                                                const Radius.circular(20),
                                            topRight: const Radius.circular(20),
                                            bottomRight: Radius.circular(
                                                message.senderId ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid
                                                    ? 0
                                                    : 20),
                                            topLeft: Radius.circular(
                                                message.senderId ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid
                                                    ? 20
                                                    : 0),
                                          ),
                                          color:
                                              message.senderId == currentuserid
                                                  ? Colors.grey.shade800
                                                  : const Color.fromARGB(
                                                          255, 78, 77, 77)
                                                      .withOpacity(0.6),
                                        ),
                                        constraints:
                                            BoxConstraints(maxWidth: w * 2 / 3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 30),
                                              child: Text(
                                                message.textMessage,
                                                style: GoogleFonts.outfit(
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  DateFormat.jm()
                                                      .format((message.time
                                                          .toDate()))
                                                      .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                ),
                                                if (message.senderId ==
                                                    currentuserid)
                                                  const Icon(
                                                    Icons.done,
                                                    size: 15,
                                                    color: Colors.white,
                                                  )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
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
                  //?enter a message widget-----------------------------------
                  TextFormMesasge(chatController: chatController),
                  IconButton(
                    onPressed: () {
                      if (chatController.text.trim().isNotEmpty) {
                        ChatService().sendTextMessage(
                          currentuserid,
                          userid,
                          chatController.text.trim(),
                        );
                        chatController.clear();
                      }
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
}
