import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  NoteModel({
    required this.title,
    required this.content,
    required this.noteColor,
    required this.dateTime,
  });
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  Color noteColor;
  @HiveField(3)
  DateTime dateTime;
}
