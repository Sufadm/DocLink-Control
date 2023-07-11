import 'package:doclink_control/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const CustomAppBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        //  elevation: 0,
        iconTheme: const IconThemeData(
          color: kWhiteColor, // Change your color here
        ),
        title: Text(text,
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: kDarkBlueButtonsColor
        //centerTitle: true,
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
