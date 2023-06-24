import 'package:flutter/material.dart';

import '../../../../shared/const/const.dart';
import '../../appointments_details/apointment_details.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: GridView.builder(
          padding: EdgeInsets.all(screenWidth * 0.01),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: screenWidth * 0.017,
            mainAxisSpacing: screenHeight * 0.010,
          ),
          itemCount: 4, // Replace with the actual number of items
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AppointmentDetails();
              })),
              child: Container(
                color: greylight1,
                child: Center(
                  child: Text(
                    'Patient ${index + 1}',
                    style: kTextStyleMediumBlack.copyWith(
                        fontSize: screenWidth * 0.04),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
