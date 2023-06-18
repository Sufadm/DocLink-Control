import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class PrescriptionDetailsPage extends StatelessWidget {
  const PrescriptionDetailsPage({Key? key}) : super(key: key);

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
              height: 200,
              width: double.infinity,
              color: greylight1,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight25,
                    Text(
                      'Drug: ',
                      style: kTextStyleLargeBlack,
                    ),
                    kHeight10,
                    Text(
                      'Usage:',
                      style: kTextStyleLargeBlack,
                    ),
                    kHeight10,
                    Text(
                      'Duration:',
                      style: kTextStyleLargeBlack,
                    ),
                    kHeight10,
                    Text(
                      'Remarks:',
                      style: kTextStyleLargeBlack,
                    ),
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
