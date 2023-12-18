import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_application/controller/checklist_controller.dart';
import 'package:note_application/controller/hive_controller.dart';
import 'package:note_application/main.dart';
import 'package:note_application/model/checklist_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/edit_checklist_screen/edit_checklist_widgets/edit_checklist_item.dart';
import 'package:note_application/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class EditChecklistScreen extends StatefulWidget {
  String appBarTitle;
  String? title;
  List<ContentModel>? contentList;
  DateTime? date;
  TimeOfDay? time;
  int? colorIndex, noteKey;

  EditChecklistScreen({
    super.key,
    required this.appBarTitle,
    this.title,
    this.contentList,
    this.date,
    this.time,
    this.colorIndex,
    this.noteKey,
  });

  @override
  State<EditChecklistScreen> createState() => _EditChecklistScreenState();
}

class _EditChecklistScreenState extends State<EditChecklistScreen> {
  HiveController hiveController = HiveController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    getData();
    titleController = TextEditingController(text: widget.title);
    Provider.of<ChecklistController>(context, listen: false)
        .intialCheckList(widget.contentList ?? []);
    setState(() {});
    super.initState();
  }

  Future<void> getData() async {
    await hiveController.initializeHive(NoteType.checklist);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leading: BackButton(
          color: ColorConstant.secondaryColor,
        ),
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
            color: ColorConstant.secondaryColor,
          ),
        ),
        actions: [
          Consumer<ChecklistController>(
            builder: (context, value, child) => IconButton(
              onPressed: () async {
                List<ContentModel> list = value.checkList;
                if (titleController.text.isEmpty || list.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        titleController.text.isEmpty
                            ? 'Title is empty'
                            : 'Add atleast one item',
                      ),
                    ),
                  );
                } else {
                  await hiveController.saveData(
                    widget.noteKey ?? hiveController.counter,
                    ChecklistModel(
                      title: widget.title ?? titleController.text.trim(),
                      contentList: list,
                      date: widget.date ?? DateTime.now(),
                      time: widget.time ?? TimeOfDay.now(),
                      colorIndex: widget.colorIndex ??
                          Random().nextInt(ColorConstant.colorsList.length),
                    ),
                  );
                  value.clearContent();
                  setState(() {});
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
              icon: Icon(
                Icons.check_rounded,
                color: ColorConstant.secondaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.primaryColor,
                    width: DimenConstant.borderWidth,
                  ),
                ),
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: ColorConstant.primaryColor,
                ),
              ),
              controller: titleController,
              cursorColor: ColorConstant.primaryColor,
              autofocus: true,
            ),
            DimenConstant.separator,
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.primaryColor,
                    width: 2,
                  ),
                ),
                labelText: 'Add to list',
                labelStyle: TextStyle(
                  color: ColorConstant.primaryColor,
                ),
                suffixIcon: Consumer<ChecklistController>(
                  builder: (context, value, child) => IconButton(
                    onPressed: () {
                      contentController.text == ''
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Empty item',
                                ),
                              ),
                            )
                          : value.addContent(
                              itemName: contentController.text.trim());
                      contentController.clear();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.add_rounded,
                      size: 30,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
              controller: contentController,
              cursorColor: ColorConstant.primaryColor,
              autofocus: true,
            ),
            DimenConstant.separator,
            Expanded(
              child: StatefulBuilder(
                builder: (context, setListState) =>
                    Consumer<ChecklistController>(
                  builder: (context, value, child) => ListView.builder(
                    itemBuilder: (context, index) => EditCheckListItem(
                      itemName: value.checkList[index].item,
                      onClearPressed: () {
                        value.deleteContent(index);
                        setListState(() {});
                      },
                    ),
                    itemCount: value.checkList.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
