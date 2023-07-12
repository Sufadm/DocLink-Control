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
              const MessageListDoctors(

                  // Replace with your widget that represents a message
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
