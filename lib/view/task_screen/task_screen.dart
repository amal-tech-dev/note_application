import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/task_model.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/task_screen/task_widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskModel> taskList = [];
  List keysList = [];

  @override
  void initState() {
    initialiseHive();
    super.initState();
  }

  Future<void> initialiseHive() async {
    var box = await Hive.box<TaskModel>('taskBox');
    taskList = box.values.toList();
    keysList = box.keys.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: ListView.separated(
          itemBuilder: (context, index) => TaskTile(
            title: 'title',
            description: 'description',
            dueDate: DateTime.now(),
            isOverDue: false,
            isDone: false,
          ),
          separatorBuilder: (context, index) => DimenConstant.separator,
          itemCount: 10,
        ),
      ),
    );
  }
}
