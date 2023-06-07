import 'package:doclink_control/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const TextFormFieldWidget({
    Key? key,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.lato(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: kDarkBlueButtonsColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: kDarkBlueButtonsColor, // Change to your desired border color
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
    );
  }
}


// class TextFormFieldWidget extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
//   final TextInputType? keyboardType;
//   final bool obscureText;
//   final String? Function(String?)? validator;
//   final ValueChanged<String>? onChanged;

//   const TextFormFieldWidget({
//     super.key,
//     required this.hintText,
//     required this.icon,
//     this.keyboardType,
//     this.obscureText = false,
//     this.validator,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: GoogleFonts.lato(),
        
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(
//             color: kDarkBlueButtonsColor, // Replace with your desired color
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(
//             color: Colors.red, // Change to your desired error border color
//           ),
//         ),
//         prefixIcon: Icon(
//           icon, // Replace with the desired icon
//           color: Colors.grey, // Replace with the desired color
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(
//             color: kDarkBlueButtonsColor, // Replace with your desired color
//           ),
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 17),
//       ),
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       validator: validator,
//       onChanged: onChanged,
//     );
//   }
// }
