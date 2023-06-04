import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';

class ElevatedButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ElevatedButtons({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
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
