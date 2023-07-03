import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/service/adddetails_service.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:flutter/material.dart';

class AllDetail extends StatelessWidget {
  const AllDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: 'All Detail',
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirestoreAddDetailService().getDetailsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final document = snapshot.data;
                  final place = document?.data()?['place'];
                  final fee = document?.data()?['fee'];
                  final time = document?.data()?['time'];

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 150,
                        width: double.infinity,
                        color: greylight1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Place: ${place ?? 'No Data'}',
                                style: kTextStyleMediumBlack,
                              ),
                              kHeight10,
                              Text(
                                'Fees:  ${fee ?? 'No Data'}',
                                style: kTextStyleMediumBlack,
                              ),
                              kHeight10,
                              Text(
                                'Time: ${time ?? 'No Data'}',
                                style: kTextStyleMediumBlack,
                              ),
                            ],
                          ),
                        )),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator(); // Show a progress indicator while waiting for data
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
