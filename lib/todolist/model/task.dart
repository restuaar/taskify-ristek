class Task {
  static List<Task> listTask = [];

  final String title;
  final String description;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final String category;
  final bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.category,
    required this.isCompleted,
  });
}
