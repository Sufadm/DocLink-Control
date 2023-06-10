import 'package:flutter/material.dart';

import '../const/const.dart';

class HeadingTextWidget extends StatelessWidget {
  final String text;
  const HeadingTextWidget(
      {super.key, required this.screenWidth, required this.text});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kTextStyleLargeBlack.copyWith(fontSize: screenWidth * 0.055),
    );
  }
}
