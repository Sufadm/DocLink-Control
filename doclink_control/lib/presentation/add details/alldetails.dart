import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/service/adddetails_service.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'editscreen.dart';

class TimeDetails extends StatelessWidget {
  final String doctorId;

  const TimeDetails({Key? key, required this.doctorId}) : super(key: key);

  Stream<QuerySnapshot<Map<String, dynamic>>> getDetailsStream(
      String doctorId) {
    return FirebaseFirestore.instance
        .collection('adddetails')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlueButtonsColor,
        title: const Text('Time Details'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getDetailsStream(doctorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final details = snapshot.data!.docs;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
              ),
              itemCount: details.length,
              itemBuilder: (context, index) {
                final detail = details[index].data();
                final startTime = detail['startTime'];
                final endTime = detail['endTime'];
                final timePerPerson = detail['timePerPerson'];
                final fee = detail['fee'];
                //  final id = detail['id'];
                //final date = detail['date'];
                return ListTile(
                  title: Text('Start Time: $startTime'),
                  subtitle: Text(
                    'End Time: $endTime\n'
                    'Time per Person: $timePerPerson\n'
                    'Appointment Fee: $fee',
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (String option) {
                      if (option == 'delete') {
                        // Delete option selected, handle the deletion logic here
                        FirestoreAddDetailService().deleteDetail(doctorId);
                      } else if (option == 'edit') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditScreen(
                            profileData: detail,
                          );
                        }));
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
