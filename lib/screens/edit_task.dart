// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskify/shared/shared.dart';
import 'package:taskify/models/task.dart';
import 'package:taskify/widgets/categoryinput.dart';
import 'package:taskify/widgets/labeltext.dart';
import 'package:taskify/widgets/todolistbar.dart';

class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateInputStart = TextEditingController();
  TextEditingController dateInputEnd = TextEditingController();
  TextEditingController timeInputStart = TextEditingController();
  TextEditingController timeInputEnd = TextEditingController();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    Task task = widget.task;
    dateInputStart.text = task.startDate;
    dateInputEnd.text = task.endDate;
    timeInputStart.text = task.startTime;
    timeInputEnd.text = task.endTime;

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColour,
        appBar: AppBarToDoList.buildAppBar(context, "Edit Task"),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text(task.title,
                                style: defaultText.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColour)),
                            Spacer(),
                          ],
                        ),
                        LabelText(title: "Title"),
                        Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            initialValue: task.title,
                            decoration: inputDecoration(
                              hintText: task.title,
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
                            initialValue: task.description,
                            keyboardType: TextInputType.multiline,
                            decoration: inputDecoration(
                              hintText: task.description,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        LabelText(title: "Category"),
                        if (task.category == "Daily Task")
                          Expanded(
                            child: InkWell(
                              splashColor: primaryColour.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              child: CategoryInput(
                                text: "Daily Task",
                                category: "Daily Task",
                              ),
                            ),
                          ),
                        if (task.category == "Personal Task")
                          Expanded(
                            child: InkWell(
                              splashColor: primaryColour.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              child: CategoryInput(
                                text: "Personal Task",
                                category: "Personal Task",
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 16,
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
                                    initialDate:
                                        DateTime.parse(dateInputStart.text),
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
                                  hintText: timeInputStart.text,
                                ),
                                readOnly: true,
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: int.parse(
                                          timeInputStart.text.substring(0, 2)),
                                      minute: int.parse(
                                          timeInputStart.text.substring(3, 5)),
                                    ),
                                    builder: (BuildContext context, child) {
                                      return themeData(context, child);
                                    },
                                  );

                                  if (pickedTime == null) {
                                    return;
                                  }

                                  setState(() {
                                    timeInputStart.text =
                                        convertTimeOfDay(pickedTime);
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
                                    initialDate:
                                        DateTime.parse(dateInputEnd.text),
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
                                    initialTime: TimeOfDay(
                                      hour: int.parse(
                                          timeInputEnd.text.substring(0, 2)),
                                      minute: int.parse(
                                          timeInputEnd.text.substring(3, 5)),
                                    ),
                                    builder: (BuildContext context, child) {
                                      return themeData(context, child);
                                    },
                                  );

                                  if (pickedTime == null) {
                                    return;
                                  }

                                  setState(() {
                                    timeInputEnd.text = convertTimeOfDay(pickedTime);
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
                              "Edit Task",
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
