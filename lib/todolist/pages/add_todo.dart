// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taskify/shared/shared.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColour,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SafeArea(
            child: AppBar(
              backgroundColor: primaryColour,
              elevation: 0,
              title: Text(
                "Add Task",
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
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(64, 46),
                      topRight: Radius.elliptical(64, 46),
                    ),
                    color: backgroundColour,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            "Discover More",
                            style: defaultText.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
