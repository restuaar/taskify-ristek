import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskify/models/task_isar.dart';

class TaskDatabase {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskIsarSchema],
      directory: dir.path,
    );
  }

  final List<TaskIsar> currentTasks = [];

  Future<List<TaskIsar>> addTask(TaskIsar task) async {
    final newTask = TaskIsar()
      ..title = task.title
      ..description = task.description
      ..startDate = task.startDate
      ..startTime = task.startTime
      ..endDate = task.endDate
      ..endTime = task.endTime
      ..category = task.category
      ..isCompleted = task.isCompleted;
    await isar.writeTxn(() => isar.taskIsars.put(newTask));
    return await fetchTasks();
  }

  Future<List<TaskIsar>> fetchTasks() async {
    final tasks = await isar.taskIsars.where().findAll();
    return tasks;
  }

  Future<void> updateTask(TaskIsar task) async {
    final existingTask = await isar.taskIsars.get(task.id);
    if (existingTask != null) {
      existingTask.title = task.title;
      existingTask.description = task.description;
      existingTask.startDate = task.startDate;
      existingTask.startTime = task.startTime;
      existingTask.endDate = task.endDate;
      existingTask.endTime = task.endTime;
      existingTask.category = task.category;
      existingTask.isCompleted = task.isCompleted;
      await isar.writeTxn(() => isar.taskIsars.put(existingTask));
    }
  }

  Future<void> deleteTask(TaskIsar task) async {
    await isar.writeTxn(() => isar.taskIsars.delete(task.id));
  }
}
