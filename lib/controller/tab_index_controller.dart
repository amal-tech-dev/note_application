import 'package:flutter/cupertino.dart';
import 'package:note_application/main.dart';

class TabIndexController with ChangeNotifier {
  int defaultIndex = 0;

  // set default index
  setIndex(NoteType type) {
    switch (type) {
      case NoteType.note:
        defaultIndex = 0;
        break;
      case NoteType.checklist:
        defaultIndex = 1;
        break;
      case NoteType.task:
        defaultIndex = 2;
        break;
    }
    notifyListeners();
  }
}
