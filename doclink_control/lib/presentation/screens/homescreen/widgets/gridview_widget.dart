import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../appointments_details/apointment_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GridViewWidget extends StatelessWidget {
  final String doctorId;
  const GridViewWidget({
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
                  final userName = appointmentGroup[0]['userName'];
                  final imageurl = appointmentGroup[0]['image'];
                  // final userid = appointmentGroup[0]['userId'];
                  final appointmentCount = appointmentGroup.length;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AppointmentDetails(
                            image: imageurl,
                            name: '$userName',
                            //userId: userid,
                          );
                        }),
                      );
                    },
                    child: Container(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(userName, style: GoogleFonts.lato()),
                          ),
                          const SizedBox(height: 10),
                          Text('Appointment $appointmentCount')
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


// class GridViewWidget extends StatelessWidget {
//   final String doctorId;
//   const GridViewWidget({
//     Key? key,
//     required this.screenWidth,
//     required this.screenHeight,
//     required this.doctorId,
//   }) : super(key: key);

//   final double screenWidth;
//   final double screenHeight;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('doctors')
//             .where('doctorId', isEqualTo: doctorId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final doctors = snapshot.data!.docs;
//             if (doctors.isEmpty) {
//               return Text(
//                 'No Appointments',
//                 style: GoogleFonts.lato(color: Colors.red),
//               );
//             }
//             return GestureDetector(
//               child: GridView.builder(
//                 padding: EdgeInsets.all(screenWidth * 0.01),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 1.0,
//                   crossAxisSpacing: screenWidth * 0.017,
//                   mainAxisSpacing: screenHeight * 0.010,
//                 ),
//                 itemCount: doctors.length,
//                 itemBuilder: (context, index) {
//                   final doctor = doctors[index];
//                   final userName = doctor['userName'];
//                   final imageurl = doctor['image'];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return AppointmentDetails(
//                             image: imageurl,
//                             name: userName,
//                           );
//                         }),
//                       );
//                     },
//                     child: Container(
//                         color: Colors.grey[200],
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: Text(userName, style: GoogleFonts.lato()),
//                             ),
//                             kHeight10,
//                             Text('appointement ${index + 1}')
//                           ],
//                         )),
//                   );
//                 },
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return SizedBox.fromSize();
//           }
//         },
//       ),
//     );
//   }
// }
