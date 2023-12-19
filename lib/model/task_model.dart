import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 3)
class TaskModel {
  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.state,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  TaskState state;
}

@HiveType(typeId: 4)
enum TaskState {
  @HiveField(0)
  upcoming,
  @HiveField(1)
  completed,
  @HiveField(2)
  overdue,
}
