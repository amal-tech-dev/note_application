import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/controller/hive_controller.dart';
import 'package:note_application/main.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/edit_note_screen/edit_note_screen.dart';
import 'package:note_application/view/note_screen/note_widgets/note_tile.dart';
import 'package:note_application/view/note_view_screen/note_view_screen.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  HiveController hiveController = HiveController();

  @override
  void initState() {
    getHive();
    super.initState();
  }

  Future<void> getHive() async {
    await hiveController.initializeHive(NoteType.note);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: MasonryGridView(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          crossAxisSpacing: DimenConstant.edgePadding,
          mainAxisSpacing: DimenConstant.edgePadding,
          children: List.generate(
            hiveController.keysList.length,
            (index) => InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteViewScreen(
                    title: hiveController.valuesList[index].title,
                    content: hiveController.valuesList[index].content,
                    dateTime: hiveController.valuesList[index].dateTime,
                    onEditPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNoteScreen(
                            appBarTitle: 'Edit Note',
                            title: hiveController.valuesList[index].title,
                            content: hiveController.valuesList[index].content,
                            dateTime: hiveController.valuesList[index].dateTime,
                            noteKey: hiveController.keysList[index],
                          ),
                        ),
                      );
                    },
                    onDeletePressed: () async {
                      var box = await Hive.box<NoteModel>('noteBox');
                      box.delete(hiveController.keysList[index]);
                      hiveController.valuesList = box.values.toList();
                      hiveController.keysList = box.keys.toList();
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ),
              ),
              child: NoteTile(
                title: hiveController.valuesList[index].title,
                content: hiveController.valuesList[index].content,
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
                  await hiveController
                      .deleteData(hiveController.keysList[index]);
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
