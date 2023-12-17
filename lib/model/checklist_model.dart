import 'package:hive/hive.dart';

part 'checklist_model.g.dart';

@HiveType(typeId: 1)
class ChecklistModel {
  ChecklistModel({
    required this.title,
    required this.contentList,
    required this.dateTime,
    required this.colorIndex,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  List<ContentModel> contentList;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  int colorIndex;
}

@HiveType(typeId: 2)
class ContentModel {
  ContentModel({
    required this.item,
    required this.check,
  });

  @HiveField(0)
  String item;
  @HiveField(1)
  bool check;
}
