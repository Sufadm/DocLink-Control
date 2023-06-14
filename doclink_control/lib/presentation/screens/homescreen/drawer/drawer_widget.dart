import 'package:doclink_control/presentation/screens/homescreen/drawer/widgets/listtile_widget.dart';
import 'package:doclink_control/presentation/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../const/const.dart';
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            accountName: Text(
              "Sufad M",
              style: kTextStyleMediumBlack,
            ),
            accountEmail: Text(
              "SufadZan@gmail.com",
              style: GoogleFonts.lato(color: Colors.black),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://media.istockphoto.com/id/1189304032/photo/doctor-holding-digital-tablet-at-meeting-room.jpg?s=612x612&w=0&k=20&c=RtQn8w_vhzGYbflSa1B5ea9Ji70O8wHpSgGBSh0anUg='),
            ),
          ),
          ListTileWidget(
              subtitle: 'Message From Patients', onTap: () {}, title: 'Chat'),
          ListTileWidget(
              subtitle: 'Add or Update Timimg and Payment',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ScheduleTime();
                }));
              },
              title: 'Add Detail'),
          ListTileWidget(
              subtitle: 'Details',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProfileScreen();
                }));
              },
              title: 'Profile'),
          ListTileWidget(
              subtitle: 'Logout from device',
              onTap: () async {
                await auth.logout();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              title: 'Logout'),
        ],
      ),
    );
  }
}
