// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:taskify/utils/database.dart';
import 'package:taskify/models/task_isar.dart';

class TaskProvider with ChangeNotifier {
  List<TaskIsar> _tasks = [];
  late TaskDatabase _taskDatabase;

  TaskProvider() {
    _taskDatabase = TaskDatabase();
    fetchTasks();
  }

  List<TaskIsar> get tasks {
    return [..._tasks];
  }

  void fetchTasks() async {
    _tasks = await _taskDatabase.fetchTasks();
    sortTasks();
    notifyListeners();
  }

  void addTask(TaskIsar task) async {
    await _taskDatabase.addTask(task);
    fetchTasks();
  }

  void updateTask(TaskIsar task) async {
    await _taskDatabase.updateTask(task);
    fetchTasks();
  }

  void deleteTask(TaskIsar task) async {
    await _taskDatabase.deleteTask(task);
    fetchTasks();
  }

  void sortTasks() {
    _tasks.sort((a, b) {
      if (a.isCompleted.toString() != b.isCompleted.toString()) {
        return a.isCompleted ? 1 : -1;
      } else {
        if (a.category != b.category) {
          return a.category == "Personal Task" ? -1 : 1;
        } else {
          return a.endDate.compareTo(b.endDate);
        }
      }
    });
  }
}
