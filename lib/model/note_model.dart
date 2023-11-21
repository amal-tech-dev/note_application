import 'package:flutter/material.dart';

class NoteModel {
  NoteModel({
    required this.title,
    required this.content,
    required this.noteColor,
  });

  String title, content;
  Color noteColor;
}
