import 'package:flutter/material.dart';
import 'package:note_application/controller/date_time_format_controller.dart';
import 'package:note_application/controller/hive_controller.dart';
import 'package:note_application/main.dart';
import 'package:note_application/model/checklist_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/view/checklist_view_screen/checklist_view_widgets/checklist_view_tile.dart';

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
  DateTimeFormatController dateTimeFormater = DateTimeFormatController();
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
    list.add(ContentModel(item: item, check: value));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leading: BackButton(
          color: ColorConstant.secondaryColor,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: ColorConstant.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: widget.onEditPressed,
            icon: Icon(
              Icons.edit_rounded,
              color: ColorConstant.secondaryColor,
            ),
          ),
          IconButton(
            onPressed: widget.onDeletePressed,
            icon: Icon(
              Icons.delete_rounded,
              color: ColorConstant.secondaryColor,
            ),
          ),
        ],
      ),
      body: ListView.builder(
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
        itemCount: widget.contentList.length,
      ),
    );
  }
}
