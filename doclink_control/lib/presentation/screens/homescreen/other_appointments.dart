import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../appointments_details/apointment_details.dart';

class GridviewWidgetOtherAppointmentsPage extends StatelessWidget {
  final String doctorId;
  const GridviewWidgetOtherAppointmentsPage({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.doctorId,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .where('doctorId', isEqualTo: doctorId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final appointments = snapshot.data!.docs;
            if (appointments.isEmpty) {
              return Text(
                'No Appointments',
                style: GoogleFonts.lato(color: Colors.red),
              );
            }
            final groupedAppointments = groupAppointmentsByUser(appointments);

            return GestureDetector(
              child: GridView.builder(
                padding: EdgeInsets.all(screenWidth * 0.01),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: screenWidth * 0.017,
                  mainAxisSpacing: screenHeight * 0.010,
                ),
                itemCount: groupedAppointments.length,
                itemBuilder: (context, index) {
                  final appointmentGroup = groupedAppointments[index];
                  //  final date = appointmentGroup[0]['appointmentDate'];
                  final userName = appointmentGroup[0]['userName'];
                  final imageurl = appointmentGroup[0]['image'];
                  final userid = appointmentGroup[0]['userId'];
                  final age = appointmentGroup[0]['age'];
                  final gender = appointmentGroup[0]['gender'];
                  final appointmentCount = appointmentGroup.length;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AppointmentDetails(
                            times: appointmentGroup
                                .map((appointment) =>
                                    appointment['appointmentTime'] as String)
                                .toList(),
                            age: age,
                            gender: gender,
                            dates: appointmentGroup
                                .map((appointment) =>
                                    appointment['appointmentDate'] as String)
                                .toList(),
                            userId: userid,
                            image: imageurl,
                            names: appointmentGroup
                                .map((appointment) =>
                                    appointment['userName'] as String)
                                .toList(),
                            //userId: userid,
                          );
                        }),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(userName, style: GoogleFonts.outfit()),
                          ),
                          //  const SizedBox(height: 10),
                          kHeight10,
                          Text(
                            'Appointment $appointmentCount',
                            style: GoogleFonts.outfit(),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return SizedBox.fromSize();
          }
        },
      ),
    );
  }

  List<List<QueryDocumentSnapshot>> groupAppointmentsByUser(
      List<QueryDocumentSnapshot> appointments) {
    final Map<String, List<QueryDocumentSnapshot>> groupedMap = {};
    for (final appointment in appointments) {
      final userName = appointment['userName'];
      if (groupedMap.containsKey(userName)) {
        groupedMap[userName]!.add(appointment);
      } else {
        groupedMap[userName] = [appointment];
      }
    }
    return groupedMap.values.toList();
  }
}
