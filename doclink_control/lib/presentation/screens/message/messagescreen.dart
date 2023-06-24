import 'package:doclink_control/presentation/screens/message/chatpage/chatpage.dart';
import 'package:doclink_control/presentation/screens/message/widget/messagelist.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../shared/const/const.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Message Screen'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBar(
                hintText: 'Search a patient',
              ),
              kHeight15,
              Text(
                'Messages',
                style: kTextStyleLargeBlack,
              ),
              kHeight15,
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemCount: 5, // Replace with the actual item count
                  itemBuilder: (BuildContext context, int index) {
                    return MessageListDoctors(
                      ontap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ChatPage();
                      })),
                      name: 'Patient Name ${index + 1}',
                    ); // Replace with your widget that represents a message
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
