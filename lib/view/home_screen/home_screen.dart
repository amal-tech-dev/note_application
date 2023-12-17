import 'package:flutter/material.dart';
import 'package:note_application/controller/floating_button_controller.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';
import 'package:note_application/view/checklist_screen/checklist_screen.dart';
import 'package:note_application/view/edit_checklist_screen/edit_checklist_screen.dart';
import 'package:note_application/view/edit_note_screen/edit_note_screen.dart';
import 'package:note_application/view/edit_task_screen/edit_task_screen.dart';
import 'package:note_application/view/note_screen/note_screen.dart';
import 'package:note_application/view/task_screen/task_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorConstant.bgColor,
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryColor,
          title: Text(
            'Notes',
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorColor: ColorConstant.secondaryColor,
            labelColor: ColorConstant.secondaryColor,
            labelStyle: TextStyle(
              fontSize: DimenConstant.titleTextSize,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'Text',
              ),
              Tab(
                text: 'List',
              ),
              Tab(
                text: 'Task',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NoteScreen(),
            ChecklistScreen(),
            TaskScreen(),
          ],
        ),
        floatingActionButton: Consumer<FloatingButtonController>(
          builder: (context, value, child) => value.isExpanded
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(
                              appBarTitle: 'Add New Task',
                              dueDate: DateTime.now(),
                            ),
                          ),
                        );
                        value.shrink();
                      },
                      backgroundColor: ColorConstant.primaryColor,
                      child: Icon(
                        Icons.task_alt,
                        color: ColorConstant.tertiaryColor,
                        size: 20,
                      ),
                      mini: true,
                    ),
                    DimenConstant.separator,
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditChecklistScreen(
                              appBarTitle: 'Add New List',
                            ),
                          ),
                        );
                        value.shrink();
                      },
                      backgroundColor: ColorConstant.primaryColor,
                      child: Icon(
                        Icons.check_box,
                        color: ColorConstant.tertiaryColor,
                        size: 20,
                      ),
                      mini: true,
                    ),
                    DimenConstant.separator,
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNoteScreen(
                              appBarTitle: 'Add New Note',
                            ),
                          ),
                        );
                        value.shrink();
                      },
                      backgroundColor: ColorConstant.primaryColor,
                      child: Icon(
                        Icons.notes,
                        color: ColorConstant.tertiaryColor,
                        size: 30,
                      ),
                    ),
                  ],
                )
              : FloatingActionButton(
                  onPressed: () => value.expand(),
                  backgroundColor: ColorConstant.primaryColor,
                  child: Icon(
                    Icons.add,
                    color: ColorConstant.tertiaryColor,
                    size: 35,
                  ),
                ),
        ),
      ),
    );
  }
}
