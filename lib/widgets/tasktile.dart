import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/providers/task_provider.dart';
import 'package:taskify/shared/shared.dart';
import 'package:taskify/models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) => Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: backgroundColour,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? primaryColour
                        : backgroundColour,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          widget.task.title,
                          style: defaultText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            decoration: widget.task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: widget.task.isCompleted
                                ? primaryColour
                                : blackColour,
                          ),
                        ),
                        subtitle: Text(
                          widget.task.description,
                          style: defaultText.copyWith(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            shape: const CircleBorder(),
                            activeColor: primaryColour,
                            value: widget.task.isCompleted,
                            onChanged: (value) {
                              setState(() {
                                widget.task.isCompleted = value!;
                                taskProvider.updateTask(
                                  taskProvider.tasks.indexOf(widget.task),
                                  widget.task,
                                );
                              });
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 1.6,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Start: ",
                                  style: defaultText.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  "${widget.task.startDate} ${widget.task.startTime}",
                                  style: defaultText.copyWith(
                                    fontSize: 12,
                                    color: primaryColour,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "End: ",
                                  style: defaultText.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  "${widget.task.endDate} ${widget.task.endTime}",
                                  style: defaultText.copyWith(
                                    fontSize: 12,
                                    color: primaryColour,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
