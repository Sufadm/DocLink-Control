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
            final doctors = snapshot.data!.docs;
            return GestureDetector(
              child: GridView.builder(
                padding: EdgeInsets.all(screenWidth * 0.01),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: screenWidth * 0.017,
                  mainAxisSpacing: screenHeight * 0.010,
                ),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  final doctorName = doctor['userName'];
                  final imageurl = doctor['image'];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AppointmentDetails(
                            image: imageurl,
                            name: doctorName,
                          );
                        }),
                      );
                    },
                    child: Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(doctorName, style: GoogleFonts.lato()),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
