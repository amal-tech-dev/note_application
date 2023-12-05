import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_application/controller/floating_button_controller.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';
import 'package:note_application/view/checkbox_list_screen/checkbox_list_screen.dart';
import 'package:note_application/view/edit_note_screen/edit_note_screen.dart';
import 'package:note_application/view/notes_screen/notes_screen.dart';
import 'package:note_application/view/task_screen/task_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final separatorBox = SizedBox(height: 15, width: 15);

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
              fontSize: 20,
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
            NotesScreen(),
            CheckboxListScreen(),
            TaskScreen(),
          ],
        ),
        floatingActionButton: Consumer(
          builder: (context, value, child) =>
              Provider.of<FloatingButtonController>(context).isExpanded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            Provider.of<FloatingButtonController>(context,
                                    listen: false)
                                .shrink();
                          },
                          backgroundColor: ColorConstant.primaryColor,
                          child: Icon(
                            Icons.task_alt,
                            color: ColorConstant.tertiaryColor,
                            size: 20,
                          ),
                          mini: true,
                        ),
                        separatorBox,
                        FloatingActionButton(
                          onPressed: () {
                            Provider.of<FloatingButtonController>(context,
                                    listen: false)
                                .shrink();
                          },
                          backgroundColor: ColorConstant.primaryColor,
                          child: Icon(
                            Icons.check_box,
                            color: ColorConstant.tertiaryColor,
                            size: 20,
                          ),
                          mini: true,
                        ),
                        separatorBox,
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
                            Provider.of<FloatingButtonController>(context,
                                    listen: false)
                                .shrink();
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
                      onPressed: () => Provider.of<FloatingButtonController>(
                              context,
                              listen: false)
                          .expand(),
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
