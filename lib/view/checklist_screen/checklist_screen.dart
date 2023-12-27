import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:echo_note/controller/hive_controller.dart';
import 'package:echo_note/main.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:echo_note/view/checklist_screen/checklist_widgets/checklist_tile.dart';
import 'package:echo_note/view/checklist_view_screen/checklist_view_screen.dart';
import 'package:echo_note/view/edit_checklist_screen/edit_checklist_screen.dart';

class ChecklistScreen extends StatefulWidget {
  ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  HiveController hiveController = HiveController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  // get data from hive
  Future<void> getData() async {
    await hiveController.initializeHive(NoteType.checklist);
    setState(() {});
  }

  // get contents from hive and return as list
  List<String> getContent(int index) {
    List<String> list = [];
    for (int i = 0;
        i < hiveController.valuesList[index].contentList.length;
        i++) {
      list.add(hiveController.valuesList[index].contentList[i].item);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: MasonryGridView.builder(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          crossAxisSpacing: DimenConstant.edgePadding,
          mainAxisSpacing: DimenConstant.edgePadding,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChecklistViewScreen(
                  title: hiveController.valuesList[index].title,
                  contentList: hiveController.valuesList[index].contentList,
                  colorIndex: hiveController.valuesList[index].colorIndex,
                  checklistKey: hiveController.keysList[index],
                  onEditPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditChecklistScreen(
                          appBarTitle: 'Edit List',
                          title: hiveController.valuesList[index].title,
                          contentList:
                              hiveController.valuesList[index].contentList,
                          noteKey: hiveController.keysList[index],
                        ),
                      ),
                    );
                  },
                  onDeletePressed: () async {
                    await hiveController
                        .deleteData(hiveController.keysList[index]);
                    setState(() {});
                  },
                ),
              ),
            ),
            child: ChecklistTile(
              title: hiveController.valuesList[index].title,
              contentList: getContent(index),
              colorIndex: hiveController.valuesList[index].colorIndex,
              onEditClicked: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditChecklistScreen(
                      appBarTitle: 'Edit List',
                      title: hiveController.valuesList[index].title,
                      contentList: hiveController.valuesList[index].contentList,
                      noteKey: hiveController.keysList[index],
                    ),
                  ),
                );
              },
              onDeleteClicked: () async {
                hiveController.deleteData(hiveController.keysList[index]);
                setState(() {});
              },
            ),
          ),
          itemCount: hiveController.keysList.length,
        ),
      ),
    );
  }
}
