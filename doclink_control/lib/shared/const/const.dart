import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//?Sized Box Widget========
const kHeight5 = SizedBox(
  height: 5,
);
const kHeight10 = SizedBox(
  height: 10,
);
const kHeight15 = SizedBox(
  height: 15,
);
const kHeight20 = SizedBox(
  height: 20,
);
const kHeight25 = SizedBox(
  height: 25,
);
const kWidth10 = SizedBox(
  width: 10,
);
const kWidth15 = SizedBox(
  width: 15,
);
//?color=======================================================
final kOutfit = GoogleFonts.outfit(color: Colors.white);
const kDarkBlueButtonsColor = Color.fromARGB(255, 1, 43, 114);
const kLightBlueColor = Color(0xFF198eb6);
const kWhiteColor = Color.fromARGB(255, 255, 255, 255);
const kBlackColor = Color.fromARGB(255, 0, 0, 0);
const greylight = Color(0xFFF4F4F4);
const greylight1 = Color.fromARGB(255, 236, 234, 234);

//?style googlefonts===========================================

final kTextStyle = GoogleFonts.lato(fontWeight: FontWeight.bold);

final kTextStyleLarge = kTextStyle.copyWith(fontSize: 20.0);
final kTextStyleMedium = kTextStyle.copyWith(fontSize: 15.0);
final kTextStyleSmall = kTextStyle.copyWith(fontSize: 10.0);
final kTextStyleLargeWhite =
    kTextStyle.copyWith(fontSize: 20.0, color: Colors.white);
final kTextStyleLargeBlack =
    kTextStyle.copyWith(fontSize: 20.0, color: Colors.black);

final kTextStyleMediumBlack =
    kTextStyle.copyWith(fontSize: 15.0, color: Colors.black);
final kTextStyleMediumWhite =
    kTextStyle.copyWith(fontSize: 15.0, color: Colors.white);
