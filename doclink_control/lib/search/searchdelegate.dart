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
                        userId: doctor['doctorId'],
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
}


// class CustomSearchDelegate extends SearchDelegate {
//   Future<QuerySnapshot<Map<String, dynamic>>> _fetchusers() {
//     return FirebaseFirestore.instance.collection('doctors').get();
//   }

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(
//         Icons.arrow_back,
//         color: Colors.black,
//       ),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
//       future: _fetchusers(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//         } else if (snapshot.hasData) {
//           final List<DocumentSnapshot<Map<String, dynamic>>> doctors =
//               snapshot.data!.docs;
//           final filteredDoctors = doctors.where((doctor) {
//             final doctorName = doctor['userName'].toString().toLowerCase();
//             return doctorName.contains(query.toLowerCase());
//           }).toList();
//           if (filteredDoctors.isEmpty) {
//             return Center(
//               child: Text(
//                 'No results found',
//                 style: kTextStyleMediumBlack,
//               ),
//             );
//           }

//           return ListView.builder(
//             itemCount: filteredDoctors.length,
//             itemBuilder: (context, index) {
//               final doctor = filteredDoctors[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(doctor['image']),
//                 ),
//                 title: Text(
//                   doctor['userName'].toString(),
//                   style: kTextStyleMediumBlack,
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PatientProfile(
//                         image: doctor['image'],
//                         name: doctor['userName'],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         } else {
//           return const Text('No users found.');
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
