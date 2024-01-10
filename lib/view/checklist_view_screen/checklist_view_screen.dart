import 'package:echo_note/controller/date_controller.dart';
import 'package:echo_note/controller/hive_controller.dart';
import 'package:echo_note/main.dart';
import 'package:echo_note/model/checklist_model.dart';
import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:echo_note/view/checklist_view_screen/checklist_view_widgets/checklist_view_tile.dart';
import 'package:flutter/material.dart';

class ChecklistViewScreen extends StatefulWidget {
  String title;
  List<ContentModel> contentList;
  VoidCallback onEditPressed, onDeletePressed;
  int checklistKey, colorIndex;

  ChecklistViewScreen({
    super.key,
    required this.title,
    required this.contentList,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.checklistKey,
    required this.colorIndex,
  });

  @override
  State<ChecklistViewScreen> createState() => _ChecklistViewScreenState();
}

class _ChecklistViewScreenState extends State<ChecklistViewScreen> {
  DateController dateTimeFormater = DateController();
  HiveController hiveController = HiveController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  // get data from Hive
  Future<void> getData() async {
    await hiveController.initializeHive(NoteType.checklist);
    setState(() {});
  }

  // change check state
  addDataToList(int index, bool value) {
    List list = widget.contentList;
    String item = list[index].item;
    list.removeAt(index);
    list.add(
      ContentModel(
        item: item,
        check: value,
      ),
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.bgColor,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primaryColor,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: widget.onEditPressed,
            icon: Icon(
              Icons.edit_rounded,
              color: ColorConstant.primaryColor,
            ),
          ),
          IconButton(
            onPressed: widget.onDeletePressed,
            icon: Icon(
              Icons.delete_rounded,
              color: ColorConstant.primaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) => ChecklistViewTile(
            item: widget.contentList[index].item,
            isCheck: widget.contentList[index].check,
            onCheckboxPressed: (value) async {
              await hiveController.saveData(
                widget.checklistKey,
                ChecklistModel(
                  title: widget.title,
                  contentList: addDataToList(index, value!),
                  colorIndex: widget.colorIndex,
                ),
              );
              setState(() {});
            },
          ),
          separatorBuilder: (context, index) => DimenConstant.separator,
          itemCount: widget.contentList.length,
        ),
      ),
    );
  }
}
