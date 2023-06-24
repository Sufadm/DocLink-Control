import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/service/firestore_service.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/presentation/screens/profile/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

            return Scaffold(
                body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
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
                            document!['imageUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    kHeight25,
                    Text(
                      'DR ${document['name']}',
                      style: GoogleFonts.lato(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    kHeight10,
                    Text(
                      'Qualification:  ${document['qualification']}',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    kHeight10,
                    Text(
                      'Categorie: ${document['category']}',
                      style: GoogleFonts.lato(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    kHeight10,
                    Text(
                      'Phone: ${document['phone']}',
                      style: GoogleFonts.lato(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    kHeight15,
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EditProfile();
                          }));
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'))
                  ],
                ),
              ),
            ));
          } else if (snapshot.hasError) {
            const Text('Error');
          }
        }
        return Container();
      },
    );
  }
}
