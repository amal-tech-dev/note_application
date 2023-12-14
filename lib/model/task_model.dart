import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 3)
class TaskModel {
  TaskModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isOverDue,
    required this.isDone,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime dueDate;
  @HiveField(3)
  bool isOverDue;
  @HiveField(4)
  bool isDone;
}
