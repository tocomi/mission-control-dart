import './task_type.dart';

class Task {
  final int id;
  final String title;
  TaskType type;
  bool done;
  final DateTime createdAt;

  Task(
    this.id,
    this.title,
    this.type,
    this.done,
    this.createdAt,
  );

}
