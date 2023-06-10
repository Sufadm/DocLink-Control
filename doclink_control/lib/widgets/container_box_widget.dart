import 'package:flutter/material.dart';

import '../const/const.dart';

class ContainerBoxWidget extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;
  const ContainerBoxWidget({
    super.key,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: greylight1,
        ),
        height: 70,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: kTextStyleMediumBlack,
              ),
              // const Icon(Icons.east)
            ],
          ),
        ),
      ),
    );
  }
}
