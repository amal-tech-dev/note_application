import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/main.dart';
import 'package:note_application/model/checklist_model.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/model/task_model.dart';

class HiveController {
  var box;
  List keysList = [];
  List valuesList = [];
  int counter = 0;

  // initializing Hive corresponding to NoteType
  Future<void> initializeHive(NoteType type) async {
    switch (type) {
      case NoteType.note:
        box = await Hive.box<NoteModel>('noteBox');
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
