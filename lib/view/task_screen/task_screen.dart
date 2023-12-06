import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';
import 'package:note_application/view/edit_note_screen/edit_note_screen.dart';
import 'package:note_application/view/notes_screen/notes_widgets/note_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_application/view/note_view_screen/note_view_screen.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
      ),
    );
  }
}