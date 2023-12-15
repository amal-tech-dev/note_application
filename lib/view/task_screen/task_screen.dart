import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  List<TaskModel> taskList = [];
  List<TaskModel> overdueTaskList = [];
  List<TaskModel> completedTaskList = [];
  List<TaskModel> upcomingTaskList = [];
  List keysList = [];

  @override
  void initState() {
    initialiseHive();
    super.initState();
  }

  // initialize Hive for TaskModel
  Future<void> initialiseHive() async {
    var box = await Hive.box<TaskModel>('taskBox');
    await checkDueDate();
    taskList = box.values.toList();
    keysList = box.keys.toList();
    overdueTaskList = await getDataFromTaskList(TaskState.overdue);
    completedTaskList = await getDataFromTaskList(TaskState.completed);
    upcomingTaskList = await getDataFromTaskList(TaskState.upcoming);
    setState(() {});
  }

  // check date exceeds current date and time
  Future<void> checkDueDate() async {
    var box = await Hive.box<TaskModel>('taskBox');
    for (int i = 0; i < box.values.toList().length; i++) {
      if (box.values.toList()[i].dueDate.isBefore(DateTime.now())) {
        box.put(
          box.keys.toList()[i],
          TaskModel(
            title: box.values.toList()[i].title,
            description: box.values.toList()[i].description,
            dueDate: box.values.toList()[i].dueDate,
            state: TaskState.overdue,
          ),
        );
      }
    }
  }

  // get specific data from taskList
  Future<List<TaskModel>> getDataFromTaskList(TaskState taskState) async {
    List<TaskModel> updatedList = [];
    for (int i = 0; i < taskList.length; i++) {
      if (taskList[i].state == taskState) updatedList.add(taskList[i]);
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
            if (index < upcomingTaskList.length) {
              return TaskTile(
                title: upcomingTaskList[index].title,
                description: upcomingTaskList[index].description,
                dueDate: upcomingTaskList[index].dueDate,
                state: TaskState.upcoming,
                onCompleted: () {},
              );
            } else if (index <
                upcomingTaskList.length + overdueTaskList.length) {
              return TaskTile(
                title: upcomingTaskList[index].title,
                description: upcomingTaskList[index].description,
                dueDate: upcomingTaskList[index].dueDate,
                state: TaskState.upcoming,
                onCompleted: () {},
              );
            } else {
              return TaskTile(
                title: upcomingTaskList[index].title,
                description: upcomingTaskList[index].description,
                dueDate: upcomingTaskList[index].dueDate,
                state: TaskState.upcoming,
                onCompleted: () {},
              );
            }
          },
          separatorBuilder: (context, index) => DimenConstant.separator,
          itemCount: taskList.length,
        ),
      ),
    );
  }
}
