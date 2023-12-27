import 'package:flutter/material.dart';
import 'package:echo_note/model/checklist_model.dart';

class ChecklistController with ChangeNotifier {
  List<ContentModel> checkList = [];

  // get content ChecklistModel and store it to a list
  intialCheckList(List<ContentModel> list) {
    checkList = (list == []) ? [] : list;
  }

  // add content to the list
  addContent({required String itemName, bool? check}) {
    checkList.add(
      ContentModel(
        item: itemName,
        check: check ?? false,
      ),
    );
    notifyListeners();
  }

  // delete content from list
  deleteContent(int index) {
    checkList.removeAt(index);
    notifyListeners();
  }

  // clear all contents form list
  clearContent() {
    checkList = [];
    notifyListeners();
  }
}
