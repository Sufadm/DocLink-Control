import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/widgets/container_box_widget.dart';
import 'package:flutter/material.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              kHeight20,
              Center(
                child: Text(
                  'Appointments',
                  style: kTextStyleLargeBlack,
                ),
              ),
              kHeight15,
              const Divider(
                thickness: 1,
              ),
              kHeight15,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ContainerBoxWidget(name: 'Patient Name 2'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ContainerBoxWidget(name: 'Patient Name 2'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
