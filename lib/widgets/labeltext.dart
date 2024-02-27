import 'package:flutter/material.dart';
import 'package:taskify/utils/shared.dart';

class LabelText extends StatelessWidget {
  final String title;
  const LabelText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: defaultText.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColour,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}
