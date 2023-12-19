import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_application/controller/hive_controller.dart';
import 'package:note_application/controller/tab_index_controller.dart';
import 'package:note_application/main.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  String appBarTitle;
  String? title, content;
  int? colorIndex, noteKey;

  EditNoteScreen({
    super.key,
    required this.appBarTitle,
    this.title,
    this.content,
    this.colorIndex,
    this.noteKey,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  HiveController hiveController = HiveController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  // get data from hive
  Future<void> getData() async {
    await hiveController.initializeHive(NoteType.note);
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
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
          IconButton(
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  contentController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      titleController.text.isEmpty
                          ? 'Title is empty'
                          : 'Content is empty',
                    ),
                  ),
                );
              } else {
                await hiveController.saveData(
                  widget.noteKey ?? hiveController.counter,
                  NoteModel(
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    colorIndex: widget.colorIndex ??
                        Random().nextInt(ColorConstant.colorsList.length),
                  ),
                );
                Provider.of<TabIndexController>(context, listen: false)
                    .setIndex(NoteType.note);
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
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                      width: DimenConstant.borderWidth,
                    ),
                  ),
                  labelText: 'Content',
                  labelStyle: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                  alignLabelWithHint: true,
                ),
                controller: contentController,
                cursorColor: ColorConstant.primaryColor,
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
