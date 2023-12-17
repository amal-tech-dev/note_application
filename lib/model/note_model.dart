import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  NoteModel({
    required this.title,
    required this.content,
    required this.dateTime,
    required this.colorIndex,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  int colorIndex;
}
