import 'package:doclink_control/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/container_box_widget.dart';
import '../profile/patientprofile/patient_profile_page.dart';

class AppointmentDetails extends StatelessWidget {
  final String age, gender, image, userId;
  final List<String> names;
  final List<String> dates;
  final List<String> times;

  const AppointmentDetails({
    Key? key,
    required this.image,
    required this.userId,
    required this.age,
    required this.gender,
    required this.names,
    required this.dates,
    required this.times,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Center(
                  child: Text(
                    'Appointments',
                    style: kTextStyleLargeBlack,
                  ),
                ),
                kHeight15,
                kHeight15,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    final name = names[index];
                    final date = dates[index];
                    final time = times[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Text(
                                date,
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold),
                              ),
                              kWidth15,
                              Text(time),
                              kWidth10,
                              const Expanded(
                                child: Divider(
                                  thickness: 0.4,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        kHeight10,
                        ContainerBoxWidget(
                          name: name,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return PatientProfile(
                                age: age,
                                gender: gender,
                                userId: userId,
                                image: image,
                                name: name,
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
