import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:echo_note/controller/hive_controller.dart';
import 'package:echo_note/main.dart';
import 'package:echo_note/model/task_model.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:echo_note/view/edit_task_screen/edit_task_screen.dart';
import 'package:echo_note/view/task_screen/task_widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  HiveController hiveController = HiveController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  // get Data from Hive
  Future<void> getData() async {
    await hiveController.initializeHive(NoteType.task);
    await checkDueDate();
    setState(() {});
  }

  // check date exceeds current date and time
  Future<void> checkDueDate() async {
    List list = await hiveController.valuesList;
    for (int i = 0; i < list.length; i++) {
      if (list[i].date.isBefore(DateTime.now())) {
        hiveController.saveData(
          hiveController.keysList[i],
          TaskModel(
            title: hiveController.valuesList[i].title,
            description: hiveController.valuesList[i].description,
            date: hiveController.valuesList[i].date,
            state: TaskState.overdue,
          ),
        );
      }
    }
  }

  // get specific data from taskList
  Future<List> getDataFromTaskList(TaskState taskState) async {
    List updatedList = [];
    List list = hiveController.valuesList;
    for (int i = 0; i < list.length; i++) {
      if (list[i].state == taskState) updatedList.add(list[i]);
    }
    return updatedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: MasonryGridView.builder(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          crossAxisSpacing: DimenConstant.edgePadding,
          mainAxisSpacing: DimenConstant.edgePadding,
          itemBuilder: (context, index) => TaskTile(
            title: hiveController.valuesList[index].title,
            description: hiveController.valuesList[index].description,
            date: hiveController.valuesList[index].date,
            state: hiveController.valuesList[index].state,
            onEditPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    appBarTitle: 'Edit Task',
                    title: hiveController.valuesList[index].title,
                    description: hiveController.valuesList[index].description,
                    date: hiveController.valuesList[index].date,
                    state: hiveController.valuesList[index].state,
                    noteKey: hiveController.keysList[index],
                  ),
                ),
              );
            },
            onDeletePressed: () async {
              await hiveController.deleteData(hiveController.keysList[index]);
              setState(() {});
            },
            onCompleted: () async {
              await hiveController.saveData(
                hiveController.keysList[index],
                TaskModel(
                  title: hiveController.valuesList[index].title,
                  description: hiveController.valuesList[index].description,
                  date: hiveController.valuesList[index].date,
                  state: TaskState.completed,
                ),
              );
              setState(() {});
            },
          ),
          itemCount: hiveController.keysList.length,
        ),
      ),
    );
  }
}
