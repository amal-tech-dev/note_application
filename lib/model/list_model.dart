import 'package:hive/hive.dart';

part 'list_model.g.dart';

@HiveType(typeId: 0)
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
