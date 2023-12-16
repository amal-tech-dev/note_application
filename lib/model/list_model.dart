import 'package:hive/hive.dart';

part 'list_model.g.dart';

@HiveType(typeId: 1)
class ChecklistModel {
  ChecklistModel({
    required this.title,
    required this.contentList,
    required this.dateTime,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  List<ContentModel> contentList;
  @HiveField(2)
  DateTime dateTime;
}

@HiveType(typeId: 2)
class ContentModel {
  ContentModel({
    required this.item,
    required this.isMarked,
  });

  @HiveField(0)
  String item;
  @HiveField(1)
  bool isMarked;
}
