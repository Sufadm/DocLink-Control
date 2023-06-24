import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/presentation/screens/homescreen/drawer/widgets/listtile_widget.dart';
import 'package:doclink_control/presentation/screens/message/messagescreen.dart';
import 'package:doclink_control/presentation/screens/profile/profile.dart';
import 'package:doclink_control/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/const/const.dart';
import '../../../../service/auth.dart';
import '../../loginscreen/loginscreen.dart';
import 'adddetails/schedulingtime.dart';

class Drawerwidget extends StatelessWidget {
  final AuthService auth = AuthService();

  Drawerwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirestoreService().getProfileStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var document = snapshot.data;

            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.white),
                    accountName: Text(
                      document!['name'],
                      style: kTextStyleMediumBlack,
                    ),
                    accountEmail: Text(
                      document['email'],
                      style: GoogleFonts.lato(color: Colors.black),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(document['imageUrl']),
                    ),
                  ),
                  ListTileWidget(
                      subtitle: 'Message From Patients',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const MessageScreen();
                        }));
                      },
                      title: 'Chat'),
                  ListTileWidget(
                      subtitle: 'Add or Update Timimg and Payment',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ScheduleTime();
                        }));
                      },
                      title: 'Add Detail'),
                  ListTileWidget(
                      subtitle: 'Details',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ProfileScreen();
                        }));
                      },
                      title: 'Profile'),
                  ListTileWidget(
                      subtitle: 'Logout from device',
                      onTap: () async {
                        await auth.logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      title: 'Logout'),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            Text(Error().toString());
          }
        }
        return Container();
      },
    );
  }
}
