import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskify/models/task.dart';

class TaskDatabase {
  List<Task> _tasks = [];
  final _myBox = Hive.box('taskify');

  List<Task> get tasks {
    return [..._tasks];
  }

  set tasks (List<Task> tasks) {
    _tasks = tasks;
  }

  void updateDatabase(List<Task> tasks) async {
    print("test 1");
    _tasks = tasks;
    print("test 2");
    await _myBox.put('tasks', _tasks);
    print("test 3");
  }

  void loadDatabase() {
    _tasks = _myBox.get('tasks');
  }

  void createInitialDatabase() {
    _tasks = [
      Task(
        title: "Task 1",
        description: "Description 1",
        startDate: "2022-01-01",
        startTime: "09:00",
        endDate: "2022-01-02",
        endTime: "05:00",
        category: "Category 1",
        isCompleted: false,
      ),
      Task(
        title: "Task 2",
        description: "Description 2",
        startDate: "2022-01-03",
        startTime: "10:00",
        endDate: "2022-01-04",
        endTime: "06:00",
        category: "Category 2",
        isCompleted: false,
      ),
      Task(
        title: "Task 3",
        description: "Description 3",
        startDate: "2022-01-05",
        startTime: "11:00",
        endDate: "2022-01-06",
        endTime: "07:00 PM",
        category: "Category 3",
        isCompleted: false,
      ),
    ];
  }
}
