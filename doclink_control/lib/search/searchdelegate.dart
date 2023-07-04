import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/presentation/screens/profile/patientprofile/patient_profile_page.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final CollectionReference<Map<String, dynamic>> doctorsRef =
      FirebaseFirestore.instance.collection('doctors');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: doctorsRef.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred.'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No users found.'));
        }

        final List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors =
            snapshot.data!.docs;
        final filteredDoctors = doctors.where((doctor) {
          final doctorName = doctor['userName'].toString().toLowerCase();
          return doctorName.contains(query.toLowerCase());
        }).toList();

        if (filteredDoctors.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: kTextStyleMediumBlack,
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredDoctors.length,
          itemBuilder: (context, index) {
            final doctor = filteredDoctors[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(doctor['image']),
              ),
              title: Text(
                doctor['userName'].toString(),
                style: kTextStyleMediumBlack,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientProfile(
                      image: doctor['image'],
                      name: doctor['userName'],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
