import 'package:flutter/material.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/database.dart';
import 'package:note_application/view/home_screen/home_widgets/note_bottom_sheet.dart';
import 'package:note_application/view/home_screen/home_widgets/note_tile.dart';
import 'package:note_application/view/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> noteList = [
    NoteModel(
      title: 'title',
      content: 'content',
      noteColor: Colors.purpleAccent.shade100,
    ),
  ];
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final noteColorList = DataBase.noteColors;
  int noteColorIndex = 0;
  final childGap = SizedBox(
    height: 15,
    width: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0D0D0),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade200,
        leading: Icon(
          Icons.notes,
          color: Colors.black,
        ),
        title: Text(
          'Note App',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          SizedBox(
            height: 50,
            width: 50,
            child: IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ),
        ],
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
          ),
          itemBuilder: (context, index) => NoteTile(
            title: noteList[index].title,
            content: noteList[index].content,
            noteColor: noteList[index].noteColor,
            onEditClicked: () {},
            onDeleteClicked: () {
              noteList.removeAt(index);
              setState(() {});
            },
          ),
          itemCount: noteList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => NoteBottomSheet(
            titleController: titleController,
            contentController: contentController,
            onSaveClicked: () {
              noteList.add(
                NoteModel(
                  title: titleController.text.trim(),
                  content: contentController.text.trim(),
                  noteColor: noteColorList[noteColorIndex]['background']!,
                ),
              );
              setState(() {});
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.greenAccent.shade200,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 35,
        ),
      ),
    );
  }
}
