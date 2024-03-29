import 'package:echo_note/controller/floating_button_controller.dart';
import 'package:echo_note/controller/tab_index_controller.dart';
import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:echo_note/utils/string_constant.dart';
import 'package:echo_note/view/checklist_screen/checklist_screen.dart';
import 'package:echo_note/view/edit_checklist_screen/edit_checklist_screen.dart';
import 'package:echo_note/view/edit_note_screen/edit_note_screen.dart';
import 'package:echo_note/view/edit_task_screen/edit_task_screen.dart';
import 'package:echo_note/view/note_screen/note_screen.dart';
import 'package:echo_note/view/task_screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: Provider.of<TabIndexController>(context).defaultIndex,
      child: Scaffold(
        backgroundColor: ColorConstant.bgColor,
        appBar: AppBar(
          backgroundColor: ColorConstant.bgColor,
          title: Text(
            StringConstant.appName,
            style: TextStyle(
              color: ColorConstant.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            dividerHeight: 0,
            indicatorColor: ColorConstant.primaryColor,
            labelColor: ColorConstant.primaryColor,
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
                            ),
                          ),
                        );
                        value.shrink();
                      },
                      backgroundColor: ColorConstant.primaryColor,
                      child: Icon(
                        Icons.task_alt_rounded,
                        color: ColorConstant.secondaryColor,
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
                        Icons.checklist_rounded,
                        color: ColorConstant.secondaryColor,
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
                        Icons.notes_rounded,
                        color: ColorConstant.secondaryColor,
                        size: 30,
                      ),
                    ),
                  ],
                )
              : FloatingActionButton(
                  onPressed: () => value.expand(),
                  backgroundColor: ColorConstant.primaryColor,
                  child: Icon(
                    Icons.add_rounded,
                    color: ColorConstant.secondaryColor,
                    size: 35,
                  ),
                ),
        ),
      ),
    );
  }
}
