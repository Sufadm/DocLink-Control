import 'package:flutter/material.dart';

import '../../../../shared/const/const.dart';

class MessageListDoctors extends StatelessWidget {
  final String name;
  final VoidCallback? ontap;
  const MessageListDoctors({
    super.key,
    required this.name,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 100,
        width: double.infinity,
        color: greylight1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: kTextStyleLargeBlack,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
