import 'package:flutter/material.dart';
import 'package:note_application/controller/date_controller.dart';
import 'package:note_application/model/task_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';

class TaskTile extends StatelessWidget {
  String title, description;
  DateTime date;
  TaskState state;
  VoidCallback onCompleted, onEditPressed, onDeletePressed;

  TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.state,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    DateController dateTimeFormat = DateController();
    return Container(
      decoration: BoxDecoration(
        color: state == TaskState.overdue
            ? Colors.red.shade300
            : state == TaskState.completed
                ? Colors.green.shade300
                : Colors.blue.shade300,
        borderRadius: BorderRadius.circular(DimenConstant.borderRadius),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: DimenConstant.titleTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          dateTimeFormat.getTaskDate(date),
          style: TextStyle(
            fontSize: DimenConstant.miniTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconColor: ColorConstant.tertiaryColor,
        collapsedBackgroundColor: Colors.transparent,
        shape: Border(),
        children: [
          Padding(
            padding: const EdgeInsets.all(DimenConstant.edgePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: DimenConstant.subTitleTextSize,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    state == TaskState.upcoming
                        ? InkWell(
                            onTap: onCompleted,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  DimenConstant.edgePadding),
                              child: Text(
                                'Mark as done',
                                style: TextStyle(
                                  fontSize: DimenConstant.miniTextSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.all(DimenConstant.edgePadding),
                            child: Text(
                              state == TaskState.overdue
                                  ? 'Task ended'
                                  : 'Completed',
                              style: TextStyle(
                                fontSize: DimenConstant.miniTextSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Edit'),
                          onTap: onEditPressed,
                        ),
                        PopupMenuItem(
                          child: Text('Delete'),
                          onTap: onDeletePressed,
                        ),
                      ],
                      color: ColorConstant.bgColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
