import 'package:flutter/material.dart';
import 'package:taskify/utils/shared.dart';

class AppBarToDoList {
  static PreferredSize buildAppBar(context, String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: SafeArea(
        child: AppBar(
          backgroundColor: primaryColour,
          elevation: 0,
          title: Text(
            title,
            style: defaultText.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: backgroundColour,
            ),
          ),
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColour,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: primaryColour,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
