import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:echo_note/controller/hive_controller.dart';
import 'package:echo_note/main.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:echo_note/view/edit_note_screen/edit_note_screen.dart';
import 'package:echo_note/view/note_screen/note_widgets/note_tile.dart';
import 'package:echo_note/view/note_view_screen/note_view_screen.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  HiveController hiveController = HiveController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  // get data from hive
  Future<void> getData() async {
    await hiveController.initializeHive(NoteType.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: MasonryGridView.builder(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          crossAxisSpacing: DimenConstant.edgePadding,
          mainAxisSpacing: DimenConstant.edgePadding,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteViewScreen(
                  title: hiveController.valuesList[index].title,
                  content: hiveController.valuesList[index].content,
                  colorIndex: hiveController.valuesList[index].colorIndex,
                  onEditPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(
                          appBarTitle: 'Edit Note',
                          title: hiveController.valuesList[index].title,
                          content: hiveController.valuesList[index].content,
                          noteKey: hiveController.keysList[index],
                        ),
                      ),
                    );
                  },
                  onDeletePressed: () async {
                    await hiveController
                        .deleteData(hiveController.keysList[index]);
                    setState(() {});
                  },
                ),
              ),
            ),
            child: NoteTile(
              title: hiveController.valuesList[index].title,
              content: hiveController.valuesList[index].content,
              colorIndex: hiveController.valuesList[index].colorIndex,
              onEditClicked: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditNoteScreen(
                      appBarTitle: 'Edit Note',
                      title: hiveController.valuesList[index].title,
                      content: hiveController.valuesList[index].content,
                      noteKey: hiveController.keysList[index],
                    ),
                  ),
                );
              },
              onDeleteClicked: () async {
                await hiveController.deleteData(hiveController.keysList[index]);
                setState(() {});
              },
            ),
          ),
          itemCount: hiveController.keysList.length,
        ),
      ),
    );
  }
}
