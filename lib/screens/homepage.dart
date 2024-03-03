// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/models/task_isar.dart';
import 'package:taskify/models/user.dart';
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
  String? searchValue;
  String name = "User";
  List<TaskIsar> tasks = [];

  @override
  void initState() {
    super.initState();
    if (user != null && user!.name != "") {
      name = user!.name.split(" ")[0];
    }
    tasks = Provider.of<TaskProvider>(context, listen: false).tasks;
  }

  void filterTasks() {
    if (searchValue != null) {
      tasks = tasks
          .where((task) =>
              task.title.toLowerCase().contains(searchValue!.toLowerCase()))
          .toList();
    }
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
                        'Hai, $name!',
                        style: defaultText.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "Stay productive today!",
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
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColour.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColour, width: 2),
                  ),
                  hintText: "Search",
                  hintStyle: defaultText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: blackColour,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
              ),
              SizedBox(height: 24),
              Consumer<TaskProvider>(builder: (context, taskProvider, child) {
                tasks = taskProvider.tasks;
                filterTasks();
                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/empty.png",
                          height: mediaQueryHeight(context) * 0.5,
                        ),
                        Text(
                          "No tasks added yet!",
                          style: defaultText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => TaskTile(task: tasks[index]),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
