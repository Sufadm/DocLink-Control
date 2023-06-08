import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../const/const.dart';
import '../../../../service/auth.dart';
import '../../loginscreen/loginscreen.dart';

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
          ListTile(
            subtitle: Text(
              'Message from patients',
              style: GoogleFonts.lato(),
            ),
            title: Text(
              "Chat",
              style: kTextStyleMediumBlack,
            ),
            onTap: () {},
          ),
          ListTile(
            subtitle: Text(
              'Add or Update Timing and Payment',
              style: GoogleFonts.lato(),
            ),
            //const Icon(Icons.settings),
            title: Text(
              "Add Detail",
              style: kTextStyleMediumBlack,
            ),
            onTap: () {},
          ),
          ListTile(
            subtitle: Text(
              'Logout from device',
              style: GoogleFonts.lato(),
            ),
            title: Text(
              "Logout",
              style: kTextStyleMediumBlack,
            ),
            onTap: () async {
              await auth.logout();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
