import 'package:hive/hive.dart';
import 'package:note_application/main.dart';

part 'task_model.g.dart';

@HiveType(typeId: 3)
class TaskModel {
  TaskModel({
    required this.title,
    this.description,
    required this.dueDate,
    required this.state,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime dueDate;
  @HiveField(3)
  TaskState state;
}
