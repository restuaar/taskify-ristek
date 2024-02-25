// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [
    Task(
      title: "Task 1",
      description: "Description 1",
      startDate: "2022-01-01",
      startTime: "09:00 AM",
      endDate: "2022-01-02",
      endTime: "05:00 PM",
      category: "Category 1",
      isCompleted: false,
    ),
    Task(
      title: "Task 2",
      description: "Description 2",
      startDate: "2022-01-03",
      startTime: "10:00 AM",
      endDate: "2022-01-04",
      endTime: "06:00 PM",
      category: "Category 2",
      isCompleted: false,
    ),
    Task(
      title: "Task 3",
      description: "Description 3",
      startDate: "2022-01-05",
      startTime: "11:00 AM",
      endDate: "2022-01-06",
      endTime: "07:00 PM",
      category: "Category 3",
      isCompleted: false,
    ),
  ];

  List<Task> get tasks {
    return [..._tasks];
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
