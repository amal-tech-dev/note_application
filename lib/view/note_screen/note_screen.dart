import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  List<NoteModel> notesList = [];
  List keysList = [];

  @override
  void initState() {
    initialiseHive();
    super.initState();
  }

  Future<void> initialiseHive() async {
    var box = await Hive.box<NoteModel>('noteBox');
    notesList = box.values.toList();
    keysList = box.keys.toList();
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
            notesList.length,
            (index) => InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteViewScreen(
                    title: notesList[index].title,
                    content: notesList[index].content,
                    dateTime: notesList[index].dateTime,
                    onEditPressed: () async {
                      var box = Hive.box<NoteModel>('noteBox');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNoteScreen(
                            appBarTitle: 'Edit Note',
                            title: box.get(keysList[index])!.title,
                            content: box.get(keysList[index])!.content,
                            noteKey: keysList[index],
                          ),
                        ),
                      );
                    },
                    onDeletePressed: () async {
                      var box = await Hive.box<NoteModel>('noteBox');
                      box.delete(keysList[index]);
                      notesList = box.values.toList();
                      keysList = box.keys.toList();
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ),
              ),
              child: NoteTile(
                title: notesList[index].title,
                content: notesList[index].content,
                onEditClicked: () async {
                  var box = Hive.box<NoteModel>('noteBox');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNoteScreen(
                        appBarTitle: 'Edit Note',
                        title: box.get(keysList[index])!.title,
                        content: box.get(keysList[index])!.content,
                        noteKey: keysList[index],
                      ),
                    ),
                  );
                },
                onDeleteClicked: () async {
                  var box = await Hive.box<NoteModel>('noteBox');
                  box.delete(keysList[index]);
                  notesList = box.values.toList();
                  keysList = box.keys.toList();
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
