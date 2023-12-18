import 'package:flutter/material.dart';
import 'package:note_application/model/checklist_model.dart';

class ChecklistController with ChangeNotifier {
  List<ContentModel> checkList = [];

  intialCheckList(List<ContentModel> list) {
    checkList = (list == []) ? [] : list;
  }

  addContent({required String itemName, bool? check}) {
    checkList.add(
      ContentModel(
        item: itemName,
        check: check ?? false,
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
