import 'package:flutter/cupertino.dart';
import 'package:echo_note/main.dart';

class TabIndexController with ChangeNotifier {
  int defaultIndex = 0;

  // set default index
  setIndex(NoteType type) {
    switch (type) {
      case NoteType.text:
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
