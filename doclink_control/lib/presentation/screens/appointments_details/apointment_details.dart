import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/shared/container_box_widget.dart';
import 'package:flutter/material.dart';

import '../profile/patientprofile/patient_profile_page.dart';

class AppointmentDetails extends StatelessWidget {
  final String name;
  final String image;

  const AppointmentDetails({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ContainerBoxWidget(
                    name: name,
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PatientProfile(
                            image: image,
                            name: name,
                          );
                        }))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
