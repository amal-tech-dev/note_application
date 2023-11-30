import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';

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
              (titleController.text.isEmpty || contentController.text.isEmpty)
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          titleController.text.isEmpty
                              ? 'Title is empty'
                              : 'Content is empty',
                        ),
                      ),
                    )
                  : await box.add(
                      NoteModel(
                        title: titleController.text.trim(),
                        content: contentController.text.trim(),
                        colorIndex: noteColorIndex,
                        dateTime: DateTime.now(),
                      ),
                    );
              print('box: ${box.keys.toList()}');
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
            separatorBox,
            Text(
              'Select Background Color',
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            separatorBox,
            Container(
              height: 60,
              child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    noteColorIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: ColorConstant.noteColors[index]['background'],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: (noteColorIndex == index)
                            ? ColorConstant.noteColors[index]['border']!
                            : Colors.transparent,
                        width: 3.5,
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
          ],
        ),
      ),
    );
  }
}
