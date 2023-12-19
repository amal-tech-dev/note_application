import 'package:flutter/material.dart';
import 'package:note_application/controller/date_time_format_controller.dart';
import 'package:note_application/controller/hive_controller.dart';
import 'package:note_application/main.dart';
import 'package:note_application/model/task_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/home_screen/home_screen.dart';

class EditTaskScreen extends StatefulWidget {
  String appBarTitle;
  String? title, description;
  DateTime? date;
  int? noteKey;

  EditTaskScreen({
    super.key,
    required this.appBarTitle,
    this.title,
    this.description,
    this.date,
    this.noteKey,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  HiveController hiveController = HiveController();
  DateTimeFormatController dateTimeFormat = DateTimeFormatController();

  @override
  void initState() {
    getData();
    titleController = TextEditingController(text: widget.title ?? '');
    descriptionController =
        TextEditingController(text: widget.description ?? '');

    setState(() {});
    super.initState();
  }

  // initialize and get data from hive
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
              if (titleController.text.isEmpty
                  // || date == DateTime.now()
                  ) {
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
                    date:
                        // date ??
                        DateTime.now(),
                    state: TaskState.upcoming,
                  ),
                );
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
                      );
                      // date = datePicked ?? DateTime.now();
                      setState(() {});
                    },
                    child: Text(
                      // dateTimeFormat.getDate(date)
                      '',
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
                      );
                      // time = timePicked ?? TimeOfDay.now();
                      setState(() {});
                    },
                    child: Text(
                      // dateTimeFormat.getTime(time)
                      '',
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
