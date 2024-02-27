import 'package:flutter/material.dart';
import 'package:taskify/utils/shared.dart';

class CategoryInput extends StatelessWidget {
  final String category;
  final String text;

  const CategoryInput({super.key, required this.text, required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 48,
        width: 160,
        decoration: BoxDecoration(
          color: category == text ? primaryColour : backgroundColour,
          borderRadius: BorderRadius.circular(10),
          border: category != text
              ? Border.all(
                  color: primaryColour,
                  width: 1.6,
                )
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: defaultText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: category == text ? backgroundColour : primaryColour,
            ),
          ),
        ),
      ),
    );
  }
}
