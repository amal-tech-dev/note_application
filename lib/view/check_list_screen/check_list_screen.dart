import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/list_model.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/check_list_screen/check_list_widgets/check_list_tile.dart';
import 'package:note_application/view/check_list_view_screen/check_list_view_screen.dart';
import 'package:note_application/view/edit_check_list_screen/edit_check_list_screen.dart';

class CheckListScreen extends StatefulWidget {
  CheckListScreen({super.key});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  List<ChecklistModel> checkboxList = [];
  List keysList = [];

  @override
  void initState() {
    initialiseHive();
    super.initState();
  }

  Future<void> initialiseHive() async {
    var box = await Hive.box<ChecklistModel>('checkListBox');
    checkboxList = box.values.toList();
    keysList = box.keys.toList();
    setState(() {});
  }

  List<String> getContent(int index) {
    List<String> list = [];
    for (int i = 0; i < checkboxList[index].contentList.length; i++)
      list.add(checkboxList[index].contentList[i].item);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: ListView.separated(
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckListViewScreen(
                  title: checkboxList[index].title,
                  contentList: checkboxList[index].contentList,
                  dateTime: checkboxList[index].dateTime,
                  onEditPressed: () async {
                    var box = Hive.box<ChecklistModel>('checkListBox');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCheckListScreen(
                          appBarTitle: 'Edit List',
                          title: box.get(keysList[index])!.title,
                          contentList: box.get(keysList[index])!.contentList,
                          noteKey: keysList[index],
                        ),
                      ),
                    );
                  },
                  onDeletePressed: () async {
                    var box = await Hive.box<ChecklistModel>('checkListBox');
                    box.delete(keysList[index]);
                    checkboxList = box.values.toList();
                    keysList = box.keys.toList();
                    setState(() {});
                  },
                ),
              ),
            ),
            child: CheckListTile(
              title: checkboxList[index].title,
              contentList: getContent(index),
              dateTime: checkboxList[index].dateTime,
              onEditClicked: () async {
                var box = Hive.box<ChecklistModel>('checkListBox');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCheckListScreen(
                      appBarTitle: 'Edit List',
                      title: box.get(keysList[index])!.title,
                      contentList: box.get(keysList[index])!.contentList,
                      noteKey: keysList[index],
                    ),
                  ),
                );
              },
              onDeleteClicked: () async {
                var box = await Hive.box<ChecklistModel>('checkListBox');
                box.delete(keysList[index]);
                checkboxList = box.values.toList();
                keysList = box.keys.toList();
                setState(() {});
              },
            ),
          ),
          separatorBuilder: (context, index) => DimenConstant.separator,
          itemCount: keysList.length,
        ),
      ),
    );
  }
}
