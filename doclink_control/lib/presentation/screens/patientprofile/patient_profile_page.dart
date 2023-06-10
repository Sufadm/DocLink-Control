import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/widgets/container_box_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:doclink_control/widgets/textwidget.dart';
import 'package:flutter/material.dart';

import 'addprescriptionpage/prescription_add_page.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({Key? key}) : super(key: key);

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
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                  ),
                ],
              ),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/premium-vector/avatar-portrait-kid-caucasian-boy-round-frame-vector-illustration-cartoon-flat-style_551425-43.jpg'),
                radius: 80,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Sufad M',
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
              const ContainerBoxWidget(name: 'Prescription'),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomElevatedButtons(
                    text: 'Prescribe',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PrescriptionAddPage();
                      }));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
