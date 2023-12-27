import 'package:hive_flutter/hive_flutter.dart';
import 'package:echo_note/main.dart';
import 'package:echo_note/model/checklist_model.dart';
import 'package:echo_note/model/text_model.dart';
import 'package:echo_note/model/task_model.dart';

class HiveController {
  var box;
  List keysList = [];
  List valuesList = [];
  int counter = 0;

  // initializing Hive corresponding to NoteType
  Future<void> initializeHive(NoteType type) async {
    switch (type) {
      case NoteType.text:
        box = await Hive.box<TextModel>('textBox');
        break;
      case NoteType.checklist:
        box = await Hive.box<ChecklistModel>('checklistBox');
        break;
      case NoteType.task:
        box = await Hive.box<TaskModel>('taskBox');
        break;
    }
    keysList = box.keys.toList();
    valuesList = box.values.toList();
    counter = keysList.isEmpty ? 0 : keysList.last + 1;
  }

  // save data to Hive
  saveData(int key, var content) {
    box.put(key, content);
    keysList = box.keys.toList();
    valuesList = box.values.toList();
  }

  // delete data from Hive
  deleteData(int key) {
    box.delete(key);
    keysList = box.keys.toList();
    valuesList = box.values.toList();
  }
}
