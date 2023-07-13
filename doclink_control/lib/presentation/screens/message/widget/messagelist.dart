import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/presentation/screens/message/widget/chatting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/const/const.dart';

class MessageListDoctors extends StatelessWidget {
  const MessageListDoctors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('doctorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final documents = snapshot.data!.docs;
          final uniqueDoctorIds = <String>{};

          return Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index].data();
                final doctorId = document['doctorId'] as String;
                final name = document['userName'] as String;
                final image = document['image'] as String;
                final gender = document['gender'] as String;
                final userId = document['userId'] as String;

                if (uniqueDoctorIds.contains(doctorId)) {
                  return const SizedBox.shrink();
                }
                uniqueDoctorIds.add(doctorId);

                return Container(
                  color: kWhiteColor,
                  child: ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChattingScreen(
                        userid: userId,
                        gender: gender,
                        name: name,
                        image: image,
                      );
                    })),
                    subtitle: Text(
                      gender,
                      style: GoogleFonts.outfit(),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: CircleAvatar(
                      maxRadius: 25,
                      // minRadius: 10,
                      backgroundImage: NetworkImage(image),
                    ),
                    title: Text(
                      name,
                      style: kTextStyleMediumBlack,
                    ),
                    trailing: const Icon(Icons.east),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// class MessageListDoctors extends StatelessWidget {
//   final VoidCallback? ontap;
//   const MessageListDoctors({
//     super.key,
//     this.ontap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final doctors = snapshot.data!.docs;

//           return Expanded(
//             child: ListView.builder(
//               itemCount: doctors.length,
//               itemBuilder: (context, index) {
//                 final doctor = doctors[index];
//                 final name = doctor[
//                     'userName']; // Replace 'name' with the actual field name in your document

//                 return GestureDetector(
//                   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
//                     return ChattingScreen(image: image, name: name, categorie: categorie)
//                   })),
//                   child: Container(
//                     height: 100,
//                     width: double.infinity,
//                     color: greylight1,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               const CircleAvatar(
//                                 radius: 10,
//                               ),
//                               const SizedBox(
//                                 width: 40,
//                               ),
//                               Container(
//                                 margin:
//                                     const EdgeInsets.only(bottom: 10, top: 10),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       name,
//                                       style: kTextStyleLargeBlack,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
