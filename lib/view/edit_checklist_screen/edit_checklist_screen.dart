import 'dart:math';

import 'package:echo_note/controller/checklist_controller.dart';
import 'package:echo_note/controller/hive_controller.dart';
import 'package:echo_note/controller/tab_index_controller.dart';
import 'package:echo_note/main.dart';
import 'package:echo_note/model/checklist_model.dart';
import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:echo_note/view/edit_checklist_screen/edit_checklist_widgets/edit_checklist_item.dart';
import 'package:echo_note/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditChecklistScreen extends StatefulWidget {
  String appBarTitle;
  String? title;
  List<ContentModel>? contentList;
  int? colorIndex, noteKey;

  EditChecklistScreen({
    super.key,
    required this.appBarTitle,
    this.title,
    this.contentList,
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

  // get data from hive
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
        surfaceTintColor: Colors.transparent,
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
                      backgroundColor: ColorConstant.primaryColor,
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.symmetric(
                        vertical: DimenConstant.edgePadding * 1.5,
                        horizontal: DimenConstant.edgePadding,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: DimenConstant.edgePadding * 2,
                        horizontal: DimenConstant.edgePadding,
                      ),
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
                      title: titleController.text.trim(),
                      contentList: list,
                      colorIndex: widget.colorIndex ??
                          Random().nextInt(ColorConstant.colorsList.length),
                    ),
                  );
                  value.clearContent();
                  Provider.of<TabIndexController>(context, listen: false)
                      .setIndex(NoteType.checklist);
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
      body: Container(
        color: ColorConstant.primaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: DimenConstant.edgePadding,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorConstant.bgColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.edgePadding,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    labelStyle: TextStyle(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  controller: titleController,
                  cursorColor: ColorConstant.primaryColor,
                  autofocus: true,
                ),
              ),
            ),
            DimenConstant.separator,
            Expanded(
              child: StatefulBuilder(
                builder: (context, setListState) =>
                    Consumer<ChecklistController>(
                  builder: (context, value, child) => ListView.separated(
                    itemBuilder: (context, index) => EditCheckListItem(
                      itemName: value.checkList[index].item,
                      onClearPressed: () {
                        value.deleteContent(index);
                        setListState(() {});
                      },
                    ),
                    separatorBuilder: (context, index) =>
                        DimenConstant.separator,
                    itemCount: value.checkList.length,
                  ),
                ),
              ),
            ),
            DimenConstant.separator,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add to List',
                      hintStyle: TextStyle(
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                    controller: contentController,
                    cursorColor: ColorConstant.secondaryColor,
                    autofocus: true,
                  ),
                ),
                Consumer<ChecklistController>(
                  builder: (context, value, child) => InkWell(
                    onTap: () {
                      contentController.text == ''
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: ColorConstant.primaryColor,
                                behavior: SnackBarBehavior.floating,
                                padding: EdgeInsets.symmetric(
                                  vertical: DimenConstant.edgePadding * 1.5,
                                  horizontal: DimenConstant.edgePadding,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: DimenConstant.edgePadding * 2,
                                  horizontal: DimenConstant.edgePadding,
                                ),
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
                    child: CircleAvatar(
                      backgroundColor: ColorConstant.tertiaryColor,
                      child: Icon(
                        Icons.add_rounded,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            DimenConstant.separator,
          ],
        ),
      ),
    );
  }
}
