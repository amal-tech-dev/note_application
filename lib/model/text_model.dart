import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'text_model.g.dart';

@HiveType(typeId: 0)
class TextModel {
  TextModel({
    required this.title,
    required this.content,
    required this.colorIndex,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  int colorIndex;
}
