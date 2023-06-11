import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../const/const.dart';

class ListTileWidget extends StatelessWidget {
  final String subtitle;
  final String title;
  final VoidCallback onTap;

  const ListTileWidget({
    Key? key,
    required this.subtitle,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(
        subtitle,
        style: GoogleFonts.lato(),
      ),
      //const Icon(Icons.settings),
      title: Text(
        title,
        style: kTextStyleMediumBlack,
      ),
      onTap: onTap,
    );
  }
}
