import 'package:doclink_control/models/prescription_add_model.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:flutter/material.dart';

class PrescriptionDetailsPage extends StatelessWidget {
  final PrescriptionModel prescription;
  const PrescriptionDetailsPage({Key? key, required this.prescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: 'Prescrioption Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            kHeight25,
            Container(
              height: 150,
              width: double.infinity,
              color: kWhiteColor,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight15,
                    Text('Drug:  ${prescription.drug}',
                        style: const TextStyle(color: kBlackColor)),
                    const Divider(),
                    //kHeight10,
                    Text('Usage:   ${prescription.usageDuration}',
                        style: const TextStyle(color: kBlackColor)),
                    const Divider(),
                    //kHeight10,
                    Text('Duration: ${prescription.duration}',
                        style: const TextStyle(color: kBlackColor)),
                    const Divider(),
                    // kHeight10,
                    Text('Remarks: ${prescription.remarks}',
                        style: const TextStyle(color: kBlackColor)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
