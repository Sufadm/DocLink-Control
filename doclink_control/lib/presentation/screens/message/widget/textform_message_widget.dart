import 'package:doclink_control/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormMesasge extends StatelessWidget {
  const TextFormMesasge({
    super.key,
    required this.chatController,
  });

  final TextEditingController chatController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: chatController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter a Message',
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintStyle: GoogleFonts.outfit(color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}
