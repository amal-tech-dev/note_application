import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';
import 'package:note_application/view/edit_screen/edit_screen.dart';
import 'package:note_application/view/home_screen/home_widgets/note_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_application/view/note_view_screen/note_view_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> notesList = [];
  List keysList = [];
  final separatorBox = SizedBox(height: 15, width: 15);

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
      backgroundColor: ColorConstant.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor.shade200,
        title: Text(
          'Note',
          style: TextStyle(
            color: ColorConstant.secondaryColor,
          ),
        ),
      ),
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
                    onEditPressed: () async {
                      var box = Hive.box<NoteModel>('noteBox');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditScreen(
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
                      builder: (context) => EditScreen(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditScreen(
              appBarTitle: 'Add New Note',
            ),
          ),
        ),
        backgroundColor: ColorConstant.primaryColor.shade200,
        child: Icon(
          Icons.add,
          color: ColorConstant.secondaryColor,
          size: 35,
        ),
      ),
    );
  }
}
