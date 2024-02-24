import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskify/shared/shared.dart';

class MyAppBar {
  static AppBar buildAppBar() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String formattedDate = DateFormat('EEEE, MMM d y').format(date);
    return AppBar(
      backgroundColor: backgroundColour,
      elevation: 0,
      title: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
        ),
        title: Text(
          'Taskify',
          style: defaultText.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          formattedDate,
          style: defaultText.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.grey.shade700),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Material(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
