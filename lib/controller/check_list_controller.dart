import 'package:flutter/material.dart';
import 'package:note_application/model/list_model.dart';

class ChecklistController with ChangeNotifier {
  List<ContentModel> checkList = [];

  intialCheckList(List<ContentModel> list) {
    checkList = (list == []) ? [] : list;
  }

  addContent(String itemName) {
    checkList.add(
      ContentModel(
        item: itemName,
        isMarked: false,
      ),
    );
    notifyListeners();
  }

  deleteContent(int index) {
    checkList.removeAt(index);
    notifyListeners();
  }

  clearContent() {
    checkList = [];
    notifyListeners();
  }
}
