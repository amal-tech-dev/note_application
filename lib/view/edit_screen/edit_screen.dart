import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';
import 'package:note_application/view/home_screen/home_screen.dart';

class EditScreen extends StatefulWidget {
  String appBarTitle;
  String? title, content;
  Color? color;

  EditScreen({
    super.key,
    required this.appBarTitle,
    this.title,
    this.content,
    this.color,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  int noteColorIndex = 0;
  final separatorBox = SizedBox(height: 15, width: 15);
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor.shade200,
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
                await box.add(
                  NoteModel(
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    dateTime: DateTime.now(),
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.secondaryColor,
                    width: 2,
                  ),
                ),
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: ColorConstant.secondaryColor,
                ),
              ),
              controller: titleController,
              cursorColor: ColorConstant.secondaryColor,
              autofocus: true,
            ),
            separatorBox,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.secondaryColor,
                      width: 2,
                    ),
                  ),
                  labelText: 'Content',
                  labelStyle: TextStyle(
                    color: ColorConstant.secondaryColor,
                  ),
                  alignLabelWithHint: true,
                ),
                controller: contentController,
                cursorColor: ColorConstant.secondaryColor,
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
