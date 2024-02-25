// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:taskify/shared/shared.dart';
import 'package:taskify/todolist/widgets/categoryinput.dart';
import 'package:taskify/todolist/widgets/labeltext.dart';
import 'package:taskify/todolist/widgets/todolistbar.dart';

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

  @override
  void initState() {
    super.initState();
    dateInputStart.text = DateFormat('MMM-d-y').format(DateTime.now());
    dateInputEnd.text = DateFormat('MMM-d-y').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColour,
        appBar: AppBarToDoList.buildAppBar(context, "Add Task"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: mediaQueryHeight(context) - 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.elliptical(64, 46),
                    topRight: Radius.elliptical(64, 46),
                  ),
                  color: backgroundColour,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
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
                            onChanged: (value) {},
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
                                    String formattedDate = DateFormat('MMM-d-y')
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
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (BuildContext context, child) {
                                      return themeData(context, child);
                                    },
                                  );

                                  if (pickedTime == null ||
                                      pickedTime == time) {
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
                                    String formattedDate = DateFormat('MMM-d-y')
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
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (BuildContext context, child) {
                                      return themeData(context, child);
                                    },
                                  );

                                  if (pickedTime == null ||
                                      pickedTime == time) {
                                    timeInputEnd.text = "00:00";
                                    return;
                                  }

                                  setState(() {
                                    time = pickedTime;
                                    timeInputEnd.text = convertTimeOfDay(time);
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Text(
                              "Create Task",
                              style: defaultText.copyWith(
                                  fontSize: 18, color: backgroundColour),
                            ),
                          ),
                        ),
                      ],
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
