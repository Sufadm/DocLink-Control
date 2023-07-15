import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);
  static const route = '/host-notification-screen';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('doctorsprofile')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('doctorNotification')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final notifications = snapshot.data!.docs;
          if (notifications.isEmpty) {
            return const Center(
              child: Text('No Notification Here'),
            );
          }
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
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Center(
                      child: Text(
                        'Notification',
                        style: kTextStyleLargeBlack,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index].data();

                          return ListTile(
                            leading: const Icon(
                              Icons.notifications,
                              color: kWhiteColor,
                            ),
                            tileColor: kDarkBlueButtonsColor,
                            title: Text(
                              notification['message'] as String,
                              style: GoogleFonts.outfit(
                                  color: kWhiteColor, fontSize: 15),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  notification['date'],
                                  style: GoogleFonts.outfit(color: kWhiteColor),
                                ),
                                Text(
                                  notification['time'],
                                  style: GoogleFonts.outfit(color: kWhiteColor),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
