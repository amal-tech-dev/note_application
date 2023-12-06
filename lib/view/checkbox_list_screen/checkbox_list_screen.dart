import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';
import 'package:note_application/view/checkbox_list_screen/checkbox_list_widgets/checkbox_list_tile.dart';
import 'package:note_application/view/edit_list_screen/edit_list_screen.dart';
import 'package:note_application/view/edit_note_screen/edit_note_screen.dart';
import 'package:note_application/view/notes_screen/notes_widgets/note_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_application/view/note_view_screen/note_view_screen.dart';

class CheckboxListScreen extends StatefulWidget {
  CheckboxListScreen({super.key});

  @override
  State<CheckboxListScreen> createState() => _CheckboxListScreenState();
}

class _CheckboxListScreenState extends State<CheckboxListScreen> {
  List<ListModel> checkboxList = [];
  List keysList = [];
  final separatorBox = SizedBox(height: 15, width: 15);

  @override
  void initState() {
    initialiseHive();
    super.initState();
  }

  Future<void> initialiseHive() async {
    var box = await Hive.box<ListModel>('listBox');
    checkboxList = box.values.toList();
    keysList = box.keys.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
          itemBuilder: (context, index) => CheckboxListItemTile(
            title: checkboxList[index].title,
            contentList: checkboxList[index].contentList,
            dateTime: checkboxList[index].dateTime,
            onEditClicked: () async {
              var box = Hive.box<ListModel>('listBox');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditListScreen(
                    appBarTitle: 'Edit List',
                    title: box.get(keysList[index])!.title,
                    contentList: box.get(keysList[index])!.contentList,
                    noteKey: keysList[index],
                  ),
                ),
              );
            },
            onDeleteClicked: () async {
              var box = await Hive.box<ListModel>('listBox');
              box.delete(keysList[index]);
              checkboxList = box.values.toList();
              keysList = box.keys.toList();
              setState(() {});
            },
          ),
          separatorBuilder: (context, index) => separatorBox,
          itemCount: keysList.length,
        ),
      ),
    );
  }
}
