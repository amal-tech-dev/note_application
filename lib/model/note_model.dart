import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  NoteModel({
    required this.title,
    required this.content,
    required this.dateTime,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  DateTime dateTime;
}

@HiveType(typeId: 1)
class ListModel {
  ListModel({
    required this.title,
    required this.contentList,
    required this.dateTime,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  List<String> contentList;
  @HiveField(2)
  DateTime dateTime;
}

@HiveType(typeId: 2)
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
