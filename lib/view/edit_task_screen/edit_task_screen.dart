import 'package:echo_note/controller/date_controller.dart';
import 'package:echo_note/controller/hive_controller.dart';
import 'package:echo_note/controller/tab_index_controller.dart';
import 'package:echo_note/main.dart';
import 'package:echo_note/model/task_model.dart';
import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:echo_note/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatefulWidget {
  String appBarTitle;
  String? title, description;
  DateTime? date;
  TaskState? state;
  int? noteKey;

  EditTaskScreen({
    super.key,
    required this.appBarTitle,
    this.title,
    this.description,
    this.date,
    this.state,
    this.noteKey,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  HiveController hiveController = HiveController();
  DateController dateController = DateController();

  @override
  void initState() {
    getData();
    titleController = TextEditingController(text: widget.title ?? '');
    descriptionController =
        TextEditingController(text: widget.description ?? '');
    dateController.filterDate(widget.date ?? DateTime.now());
    setState(() {});
    super.initState();
  }

  // get data from hive
  Future<void> getData() async {
    await hiveController.initializeHive(NoteType.task);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leading: BackButton(
          color: ColorConstant.secondaryColor,
        ),
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
            color: ColorConstant.secondaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  dateController.date == dateController.now) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      titleController.text.isEmpty
                          ? 'Title is empty'
                          : 'Select a date for the task',
                    ),
                  ),
                );
              } else {
                await hiveController.saveData(
                  widget.noteKey ?? hiveController.counter,
                  TaskModel(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    date: DateTime(
                      dateController.date.year,
                      dateController.date.month,
                      dateController.date.day,
                      dateController.time.hour,
                      dateController.time.minute,
                    ),
                    state: widget.state ?? TaskState.upcoming,
                  ),
                );
                Provider.of<TabIndexController>(context, listen: false)
                    .setIndex(NoteType.task);
                setState(() {});
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              }
            },
            icon: Icon(
              Icons.check_rounded,
              color: ColorConstant.secondaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.edgePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.primaryColor,
                    width: DimenConstant.borderWidth,
                  ),
                ),
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: ColorConstant.primaryColor,
                ),
              ),
              controller: titleController,
              cursorColor: ColorConstant.primaryColor,
              autofocus: true,
            ),
            DimenConstant.separator,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                      width: DimenConstant.borderWidth,
                    ),
                  ),
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                  alignLabelWithHint: true,
                ),
                controller: descriptionController,
                cursorColor: ColorConstant.primaryColor,
                maxLines: 50,
              ),
            ),
            DimenConstant.separator,
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      DateTime? datePicked = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 3650)),
                          ) ??
                          dateController.date;
                      dateController.setDate(DateTime(
                        datePicked.year,
                        datePicked.month,
                        datePicked.day,
                        dateController.time.hour,
                        dateController.time.minute,
                      ));
                      setState(() {});
                    },
                    child: Text(
                      dateController.dateText,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.subTitleTextSize,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      TimeOfDay? timePicked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ) ??
                          dateController.time;
                      dateController.setDate(DateTime(
                        dateController.date.year,
                        dateController.date.month,
                        dateController.date.day,
                        timePicked.hour,
                        timePicked.minute,
                      ));
                      setState(() {});
                    },
                    child: Text(
                      dateController.timeText,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.subTitleTextSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
