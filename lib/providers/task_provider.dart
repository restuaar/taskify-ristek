// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];


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

  void deleteTask(Task task) {
    _tasks.remove(task);
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
