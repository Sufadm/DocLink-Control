import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';

class CustomElevatedButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButtons({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.9,
      height: 45,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(kDarkBlueButtonsColor)),
          onPressed: onPressed,
          child: Text(
            text,
            style: GoogleFonts.lato(),
          )),
    );
  }
}
