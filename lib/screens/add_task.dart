// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskify/models/task_isar.dart';
import 'package:taskify/providers/task_provider.dart';
import 'package:taskify/utils/shared.dart';
import 'package:taskify/widgets/categoryinput.dart';
import 'package:taskify/widgets/labeltext.dart';
import 'package:taskify/widgets/todolistbar.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateInputStart = TextEditingController();
  TextEditingController dateInputEnd = TextEditingController();
  TextEditingController timeInputStart = TextEditingController();
  TextEditingController timeInputEnd = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  String _category = "Daily Task";
  String _title = "";
  String _description = "";

  @override
  void initState() {
    super.initState();
    dateInputStart.text = DateFormat('MMM-d-y').format(DateTime.now());
    dateInputEnd.text = DateFormat('MMM-d-y').format(DateTime.now());
    timeInputStart.text = "00:00";
    timeInputEnd.text = "00:00";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) => Scaffold(
          backgroundColor: primaryColour,
          appBar: AppBarToDoList.buildAppBar(context, "Add Task"),
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.elliptical(64, 46),
                    topRight: Radius.elliptical(64, 46),
                  ),
                  color: backgroundColour,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(64, 46),
                      topRight: Radius.elliptical(64, 46),
                    ),
                    color: backgroundColour,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelText(title: "Title"),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              decoration: inputDecoration(
                                hintText: 'Enter the title of the task',
                              ),
                              style: defaultText.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _title = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the title of the task';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          LabelText(title: "Description"),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              minLines: 4,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: inputDecoration(
                                hintText: "Enter the description of the task",
                              ),
                              onChanged: (value) => setState(() {
                                _description = value;
                              }),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          LabelText(title: "Category"),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  splashColor: primaryColour.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    setState(() {
                                      _category = "Personal Task";
                                    });
                                  },
                                  child: CategoryInput(
                                    text: "Personal Task",
                                    category: _category,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: InkWell(
                                  splashColor: primaryColour.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    setState(() {
                                      _category = "Daily Task";
                                    });
                                  },
                                  child: CategoryInput(
                                    text: "Daily Task",
                                    category: _category,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          LabelText(title: "Start"),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: dateInputStart,
                                  decoration: inputDecoration(
                                    prefixIcon: CupertinoIcons.calendar,
                                    hintText: dateInputStart.text,
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendar,
                                      builder: (BuildContext context, child) {
                                        return themeData(context, child);
                                      },
                                    );

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('MMM-d-y')
                                              .format(pickedDate);
                                      setState(() {
                                        dateInputStart.text = formattedDate;
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: timeInputStart,
                                  decoration: inputDecoration(
                                    prefixIcon: CupertinoIcons.clock,
                                    hintText: "00:00",
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: time,
                                      builder: (BuildContext context, child) {
                                        return themeData(context, child);
                                      },
                                    );

                                    if (pickedTime == null) {
                                      timeInputStart.text = "00:00";
                                      return;
                                    }

                                    setState(() {
                                      time = pickedTime;
                                      timeInputStart.text =
                                          convertTimeOfDay(time);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          LabelText(title: "End"),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: dateInputEnd,
                                  decoration: inputDecoration(
                                    prefixIcon: CupertinoIcons.calendar,
                                    hintText: dateInputEnd.text,
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendar,
                                      builder: (BuildContext context, child) {
                                        return themeData(context, child);
                                      },
                                    );

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('MMM-d-y')
                                              .format(pickedDate);
                                      setState(() {
                                        dateInputEnd.text = formattedDate;
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: timeInputEnd,
                                  decoration: inputDecoration(
                                    prefixIcon: CupertinoIcons.clock,
                                    hintText: "00:00",
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: time,
                                      builder: (BuildContext context, child) {
                                        return themeData(context, child);
                                      },
                                    );

                                    if (pickedTime == null) {
                                      timeInputEnd.text = "00:00";
                                      return;
                                    }

                                    setState(() {
                                      time = pickedTime;
                                      timeInputEnd.text =
                                          convertTimeOfDay(time);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 2 * 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: primaryColour,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  TaskIsar newTask = TaskIsar()
                                    ..title = _title
                                    ..description = _description
                                    ..startDate = dateInputStart.text
                                    ..startTime = timeInputStart.text
                                    ..endDate = dateInputEnd.text
                                    ..endTime = timeInputEnd.text
                                    ..category = _category
                                    ..isCompleted = false;


                                  taskProvider.addTask(newTask);

                                  Navigator.pop(context);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Task added successfully',
                                        style: defaultText.copyWith(
                                            fontSize: 16,
                                            color: backgroundColour),
                                      ),
                                    ),
                                  );
                                  _formKey.currentState!.reset();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                "Create Task",
                                style: defaultText.copyWith(
                                  fontSize: 18,
                                  color: backgroundColour,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
