import 'package:doclink_control/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.lato(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kDarkBlueButtonsColor, // Replace with your desired color
          ),
        ),
        prefixIcon: Icon(
          icon, // Replace with the desired icon
          color: Colors.grey, // Replace with the desired color
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kDarkBlueButtonsColor, // Replace with your desired color
          ),
        ),
      ),
    );
  }
}
