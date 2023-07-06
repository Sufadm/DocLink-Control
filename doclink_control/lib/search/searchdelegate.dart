import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/presentation/screens/profile/patientprofile/patient_profile_page.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _doctorsCollection =
      FirebaseFirestore.instance
          .collection('doctors')
          .where('doctorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

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
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _doctorsCollection,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors =
              snapshot.data!.docs;
          // final filteredDoctors = doctors.where((doctor) {
          //   final doctorName = doctor['userName'].toString().toLowerCase();
          //   return doctorName.contains(query.toLowerCase());
          // }).toList();
          final groupedDoctors = groupDoctorsByUserName(doctors);
          final filteredDoctors = groupedDoctors.where((doctorGroup) {
            final doctorName =
                doctorGroup[0]['userName'].toString().toLowerCase();
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
              // final doctor = filteredDoctors[index];
              final doctorGroup = filteredDoctors[index];
              final doctor = doctorGroup[0];

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
                        gender: doctor['gender'],
                        age: doctor['age'],
                        userId: doctor['userId'],
                        image: doctor['image'],
                        name: doctor['userName'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text('No users found.');
        }
      },
    );
  }

  List<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      groupDoctorsByUserName(
          List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) {
    final Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>
        groupedMap = {};

    for (final doctor in doctors) {
      final doctorName = doctor['userName'];
      if (groupedMap.containsKey(doctorName)) {
        groupedMap[doctorName]!.add(doctor);
      } else {
        groupedMap[doctorName] = [doctor];
      }
    }

    return groupedMap.values.toList();
  }
}
