import './task_type.dart';

class Task {
  final int id;
  final String title;
  final TaskType type;
  bool done;
  final DateTime createdAt;

  Task(
    this.id,
    this.title,
    this.type,
    this.done,
    this.createdAt,
  );

  changeStatus() {
    this.done = !this.done;
  }
}
