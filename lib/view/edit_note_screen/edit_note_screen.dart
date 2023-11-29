import 'package:flutter/material.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';
import 'package:note_application/utils/database.dart';

class EditNoteScreen extends StatefulWidget {
  String appBarTitle;
  String? title, content;
  Color? color;
  EditNoteScreen({
    super.key,
    required this.appBarTitle,
    this.title,
    this.content,
    this.color,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    int noteColorIndex = 0;
    final separatorBox = SizedBox(height: 15, width: 15);
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor.shade200,
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
            color: ColorConstant.secondaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
              controller: titleController,
            ),
            separatorBox,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Content',
                  border: OutlineInputBorder(),
                ),
                controller: contentController,
                maxLines: 10,
              ),
            ),
            separatorBox,
            Container(
              height: 50,
              child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () => setState(() {
                    noteColorIndex = index;
                  }),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: ColorConstant.noteColors[index]['background'],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: (noteColorIndex == index)
                            ? ColorConstant.noteColors[index]['border']!
                            : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => separatorBox,
                itemCount: ColorConstant.noteColors.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            separatorBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    titleController.clear();
                    contentController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.primaryColor.shade200,
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(60, 40),
                    ),
                  ),
                ),
                separatorBox,
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.primaryColor.shade200,
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(60, 40),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
