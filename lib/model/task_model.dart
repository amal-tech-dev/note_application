import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  TaskModel({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isDone,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  bool isDone;
}
