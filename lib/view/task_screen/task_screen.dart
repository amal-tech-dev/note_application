import 'package:flutter/material.dart';
import 'package:note_application/controller/hive_controller.dart';
import 'package:note_application/main.dart';
import 'package:note_application/model/task_model.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/task_screen/task_widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List overdueList = [];
  List completedList = [];
  List upcomingList = [];
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
    overdueList = await getDataFromTaskList(TaskState.overdue);
    completedList = await getDataFromTaskList(TaskState.completed);
    upcomingList = await getDataFromTaskList(TaskState.upcoming);
    setState(() {});
  }

  // check date exceeds current date and time
  Future<void> checkDueDate() async {
    List list = await hiveController.valuesList;
    for (int i = 0; i < list.length; i++) {
      if (list[i].dueDate.isBefore(DateTime.now())) {
        hiveController.saveData(
          hiveController.keysList[i],
          TaskModel(
            title: hiveController.valuesList[i].title,
            description: hiveController.valuesList[i].description,
            dueDate: hiveController.valuesList[i].dueDate,
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
        child: ListView.separated(
          itemBuilder: (context, index) {
            if (index < upcomingList.length) {
              return TaskTile(
                title: upcomingList[index].title,
                description: upcomingList[index].description,
                dueDate: upcomingList[index].dueDate,
                state: TaskState.upcoming,
                onCompleted: () {},
              );
            } else if (index < upcomingList.length + overdueList.length) {
              return TaskTile(
                title: overdueList[index - upcomingList.length].title,
                description:
                    overdueList[index - upcomingList.length].description,
                dueDate: overdueList[index - upcomingList.length].dueDate,
                state: TaskState.overdue,
                onCompleted: () {},
              );
            } else {
              return TaskTile(
                title: completedList[
                        index - upcomingList.length - overdueList.length]
                    .title,
                description: completedList[
                        index - upcomingList.length - overdueList.length]
                    .description,
                dueDate: completedList[
                        index - upcomingList.length - overdueList.length]
                    .dueDate,
                state: TaskState.completed,
                onCompleted: () {},
              );
            }
          },
          separatorBuilder: (context, index) => DimenConstant.separator,
          itemCount: hiveController.keysList.length,
        ),
      ),
    );
  }
}
