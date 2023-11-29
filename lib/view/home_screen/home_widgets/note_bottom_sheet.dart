import 'package:flutter/material.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';

class NoteBottomSheet extends StatefulWidget {
  NoteBottomSheet({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.onSaveClicked,
  });
  final titleController;
  final contentController;
  final onSaveClicked;

  @override
  State<NoteBottomSheet> createState() => _NoteBottomSheetState();
}

class _NoteBottomSheetState extends State<NoteBottomSheet> {
  int noteColorIndex = 0;
  final separatorBox = SizedBox(height: 15, width: 15);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Text(
            'Add Note',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          separatorBox,
          TextField(
            decoration: InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
            controller: widget.titleController,
          ),
          separatorBox,
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Content',
                border: OutlineInputBorder(),
              ),
              controller: widget.contentController,
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
                  widget.titleController.clear();
                  widget.contentController.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.greenAccent.shade200,
                  ),
                  minimumSize: MaterialStatePropertyAll(
                    Size(60, 40),
                  ),
                ),
              ),
              separatorBox,
              ElevatedButton(
                onPressed: widget.onSaveClicked,
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.greenAccent.shade200,
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
    );
  }
}
