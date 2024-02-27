import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskify/utils/shared.dart';

class MyAppBar {
  static AppBar buildAppBar() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String formattedDate = DateFormat('EEEE, MMM d y').format(date);
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: backgroundColour,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: primaryColour.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 20,
            )
          ],
          color: backgroundColour,
        ),
        child: ListTile(
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
              color: Colors.grey.shade700,
            ),
          ),
          trailing: ClipRRect(
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
        ),
      ),
      actions: const [SizedBox(width: 1)],
    );
  }
}
