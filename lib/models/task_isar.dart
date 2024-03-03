import 'package:isar/isar.dart';

part 'task_isar.g.dart';

@Collection()
class TaskIsar {
  Id id = Isar.autoIncrement;
  late String title;
  late String description;
  late String startDate;
  late String startTime;
  late String endDate;
  late String endTime;
  late String category;
  late bool isCompleted;
}
