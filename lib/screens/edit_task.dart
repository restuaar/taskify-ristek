import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskify/models/task_isar.dart';
import 'package:taskify/providers/task_provider.dart';
import 'package:taskify/utils/shared.dart';
import 'package:taskify/widgets/labeltext.dart';
import 'package:taskify/widgets/todolistbar.dart';

class EditTask extends StatefulWidget {
  final TaskIsar task;
  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKeyEdit = GlobalKey<FormState>();
  TextEditingController dateInputStart = TextEditingController();
  TextEditingController dateInputEnd = TextEditingController();
  TextEditingController timeInputStart = TextEditingController();
  TextEditingController timeInputEnd = TextEditingController();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    dateInputStart.text = widget.task.startDate;
    timeInputStart.text = widget.task.startTime;
    dateInputEnd.text = widget.task.endDate;
    timeInputEnd.text = widget.task.endTime;
    _title = widget.task.title;
    _description = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    TaskIsar task = widget.task;

    return SafeArea(
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) => Scaffold(
          backgroundColor: primaryColour,
          appBar: AppBarToDoList.buildAppBar(context, "Edit Task"),
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
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Form(
                          key: _formKeyEdit,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  Text(task.title,
                                      style: defaultText.copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColour)),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelText(title: "Title"),
                              Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  initialValue: _title,
                                  decoration: inputDecoration(
                                    hintText: _title,
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
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelText(title: "Description"),
                              Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  minLines: 4,
                                  maxLines: null,
                                  initialValue: _description,
                                  keyboardType: TextInputType.multiline,
                                  decoration: inputDecoration(
                                    hintText: task.description,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _description = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelText(title: "Category"),
                              Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 48,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: primaryColour,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      task.category,
                                      style: defaultText.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: backgroundColour,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelText(title: "Start"),
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
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.parse(
                                              dateInputStart.text),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                          initialEntryMode:
                                              DatePickerEntryMode.calendar,
                                          builder:
                                              (BuildContext context, child) {
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
                                  const SizedBox(
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
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay(
                                            hour: int.parse(timeInputStart.text
                                                .substring(0, 2)),
                                            minute: int.parse(timeInputStart
                                                .text
                                                .substring(3, 5)),
                                          ),
                                          builder:
                                              (BuildContext context, child) {
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
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelText(title: "End"),
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
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate:
                                              DateTime.parse(dateInputEnd.text),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                          initialEntryMode:
                                              DatePickerEntryMode.calendar,
                                          builder:
                                              (BuildContext context, child) {
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
                                  const SizedBox(
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
                                          initialTime: TimeOfDay(
                                            hour: int.parse(timeInputEnd.text
                                                .substring(0, 2)),
                                            minute: int.parse(timeInputEnd.text
                                                .substring(3, 5)),
                                          ),
                                          builder:
                                              (BuildContext context, child) {
                                            return themeData(context, child);
                                          },
                                        );

                                        if (pickedTime == null) {
                                          return;
                                        }

                                        setState(() {
                                          timeInputEnd.text =
                                              convertTimeOfDay(pickedTime);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              Container(
                                height: 60,
                                width:
                                    MediaQuery.of(context).size.width - 2 * 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: primaryColour,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKeyEdit.currentState!.validate()) {
                                      TaskIsar updateTask = TaskIsar()
                                        ..id = task.id
                                        ..title = _title
                                        ..description = _description
                                        ..startDate = dateInputStart.text
                                        ..startTime = timeInputStart.text
                                        ..endDate = dateInputEnd.text
                                        ..endTime = timeInputEnd.text
                                        ..category = task.category
                                        ..isCompleted = task.isCompleted;

                                      taskProvider.updateTask(
                                        updateTask,
                                      );

                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Task update successfully',
                                            style: defaultText.copyWith(
                                                fontSize: 16,
                                                color: backgroundColour),
                                          ),
                                        ),
                                      );
                                      _formKeyEdit.currentState!.reset();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
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
                      Positioned(
                        right: 20,
                        top: 20,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              taskProvider.deleteTask(task);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Task deleted successfully',
                                    style: defaultText.copyWith(
                                        fontSize: 16, color: backgroundColour),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: backgroundColour,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
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
