// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/providers/task_provider.dart';
import 'package:taskify/widgets/appbar.dart';
import 'package:taskify/widgets/tasktile.dart';
import 'package:taskify/utils/shared.dart';
import 'package:taskify/screens/add_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _welcomeMessages = [
    "Stay organized today!",
    "Ready to prioritize tasks?",
    "Stay productive today!",
    "Time for productivity.",
    "Have a nice day!",
    "Let's tackle tasks."
  ];

  String getMessageRandom() {
    final random = Random();
    final index = random.nextInt(_welcomeMessages.length);
    return _welcomeMessages[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: MyAppBar.buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, [User]',
                        style: defaultText.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        getMessageRandom(),
                        style: defaultText.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColour,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTask(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.black38,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: backgroundColour, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "Add Task",
                            style: defaultText.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: backgroundColour,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Consumer<TaskProvider>(builder: (context, taskProvider, child) {
                return ListView.builder(
                  itemCount: taskProvider.tasks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      TaskTile(task: taskProvider.tasks[index]),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
