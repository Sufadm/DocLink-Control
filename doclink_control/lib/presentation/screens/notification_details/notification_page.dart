import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/widgets/container_box_widget.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight10,
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Notification',
                  style: kTextStyleLargeBlack,
                ),
              ),
              kHeight25,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ContainerBoxWidget(
                  name: 'you have an appointment 1',
                ),
              ),
              kHeight10,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ContainerBoxWidget(name: 'you have an appointment 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
