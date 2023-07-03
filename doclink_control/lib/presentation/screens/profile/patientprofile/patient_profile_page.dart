import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/presentation/screens/message/chatpage/chatpage.dart';
import 'package:doclink_control/presentation/screens/profile/patientprofile/prescriptiondetails/prescriptiondetails.dart';
import 'package:doclink_control/shared/container_box_widget.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:doclink_control/shared/textwidget.dart';
import 'package:flutter/material.dart';

import 'addprescriptionpage/prescription_add_page.dart';

class PatientProfile extends StatelessWidget {
  final String image;
  final String name;
  const PatientProfile({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ChatPage();
                      }));
                    },
                    icon: const Icon(Icons.message),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 80,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                name,
                style: kTextStyleLargeBlack,
              ),
              SizedBox(height: screenHeight * 0.03),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                margin: EdgeInsets.only(right: screenWidth * 0.6), //
                child: HeadingTextWidget(
                  screenWidth: screenWidth,
                  text: 'Prescription',
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => kHeight10,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ContainerBoxWidget(
                        onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const PrescriptionDetailsPage();
                            })),
                        name: 'Prescription ${index + 1}');
                  },
                ),
              ),
              CustomElevatedButtons(
                text: 'Prescribe',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const PrescriptionAddPage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
