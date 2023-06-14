import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/profile/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 350),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    'https://media.istockphoto.com/id/1189304032/photo/doctor-holding-digital-tablet-at-meeting-room.jpg?s=612x612&w=0&k=20&c=RtQn8w_vhzGYbflSa1B5ea9Ji70O8wHpSgGBSh0anUg=',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            kHeight25,
            Text(
              'DR SUFAD',
              style:
                  GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            kHeight10,
            Text(
              'Qualification:  MBBS',
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            kHeight10,
            Text(
              'Categorie: Psychology',
              style:
                  GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            kHeight10,
            Text(
              'Phone: 8606682770',
              style:
                  GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            kHeight15,
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditProfile();
                  }));
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'))
          ],
        ),
      ),
    ));
  }
}
