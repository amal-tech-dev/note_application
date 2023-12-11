import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/view/home_screen/home_screen.dart';

class EditNoteScreen extends StatefulWidget {
  String appBarTitle;
  String title, content;
  int? noteKey;

  EditNoteScreen({
    super.key,
    required this.appBarTitle,
    this.title = '',
    this.content = '',
    this.noteKey,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  int counter = 0;
  List keysList = [];
  final separatorBox = SizedBox(height: 15, width: 15);
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    initialiseHive();
    super.initState();
  }

  Future<void> initialiseHive() async {
    var box = Hive.box<NoteModel>('noteBox');
    keysList = box.keys.toList();
    counter = keysList.last + 1 ?? 0;
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
              var box = Hive.box<NoteModel>('noteBox');
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
                await box.put(
                  widget.noteKey ?? counter,
                  NoteModel(
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    dateTime: DateTime.now(),
                  ),
                );
                keysList = box.keys.toList();
                counter = keysList.length;
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
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.primaryColor,
                    width: 2,
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
            separatorBox,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                      width: 2,
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
