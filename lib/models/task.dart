class Task {
  String title;
  String description;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String category;
  bool isCompleted;

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
