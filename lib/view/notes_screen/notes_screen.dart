import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model/note_model.dart';
import 'package:note_application/view/edit_note_screen/edit_note_screen.dart';
import 'package:note_application/view/notes_screen/notes_widgets/note_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_application/view/note_view_screen/note_view_screen.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
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
        padding: const EdgeInsets.all(15),
        child: MasonryGridView(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
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
