// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/utils/database.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final _mybox = Hive.box('taskify');
  TaskDatabase db = TaskDatabase();

  TaskProvider() {
    if (_mybox.get('tasks') == null) {
      db.createInitialDatabase();
    } else {
      db.loadDatabase();
    }

    _tasks = db.tasks;
  }

  List<Task> get tasks {
    return [..._tasks];
  }

  void setTasks(List<Task> tasks) {
    _tasks = tasks;
  }

  void addTask(Task task) {
    _tasks.add(task);
    sortTasks();
    notifyListeners();
  }

  void updateTask(int index, Task task) {
    _tasks[index] = task;
    sortTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    sortTasks();
    notifyListeners();
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
