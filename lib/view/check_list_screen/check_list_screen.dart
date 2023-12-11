import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/list_model.dart';
import 'package:note_application/view/check_list_screen/check_list_widgets/check_list_tile.dart';
import 'package:note_application/view/edit_list_screen/edit_list_screen.dart';

class CheckListScreen extends StatefulWidget {
  CheckListScreen({super.key});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
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
    setState(() {
      box.clear();
    });
  }

  List<String> getContent(int index) {
    List<String> contentList = [];
    for (int i = 0; i < keysList.length; i++)
      contentList.add(checkboxList[index].contentList[i].item);
    return contentList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
          itemBuilder: (context, index) => CheckListItemTile(
            title: checkboxList[index].title,
            content: getContent(index),
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
