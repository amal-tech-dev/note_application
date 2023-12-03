import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';
import 'package:note_application/view/edit_screen/edit_screen.dart';
import 'package:note_application/view/home_screen/home_widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> notesList = [];
  final separatorBox = SizedBox(height: 15, width: 15);

  @override
  void initState() {
    initialiseHive();
    super.initState();
  }

  Future<void> initialiseHive() async {
    var box = await Hive.box<NoteModel>('noteBox');
    notesList = box.values.toList();
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
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) => NoteTile(
            title: notesList[index].title,
            content: notesList[index].content,
            onEditClicked: () async {
              var box = Hive.box<NoteModel>('noteBox');

              setState(() {});
            },
            onDeleteClicked: () {
              setState(() {});
            },
          ),
          itemCount: notesList.length,
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
