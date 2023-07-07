import 'package:doclink_control/shared/const/const.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kDarkBlueButtonsColor),
          height: 60,
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white),
                ),
                // const Icon(Icons.east)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
