import 'package:flutter/material.dart';
import 'package:note_application/controller/color_controller.dart';
import 'package:note_application/main.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';

class TaskTile extends StatelessWidget {
  String title;
  String? description;
  DateTime dueDate;
  TaskState state;
  VoidCallback onCompleted;

  TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.state,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colorController = ColorController().taskColors;
    return Container(
      decoration: BoxDecoration(
        color: state == TaskState.overdue
            ? colorController['red']!['background']
            : state == TaskState.completed
                ? colorController['green']!['background']
                : colorController['blue']!['background'],
        border: Border.all(
          color: state == TaskState.overdue
              ? colorController['red']!['border']!
              : state == TaskState.completed
                  ? colorController['green']!['border']!
                  : colorController['blue']!['border']!,
          width: DimenConstant.borderWidth,
        ),
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
        iconColor: ColorConstant.tertiaryColor,
        collapsedBackgroundColor: Colors.transparent,
        children: [
          Padding(
            padding: const EdgeInsets.all(DimenConstant.edgePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: description == null ? false : true,
                  replacement: DimenConstant.separator,
                  child: Text(
                    description!,
                    style: TextStyle(
                      fontSize: DimenConstant.subTitleTextSize,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Visibility(
                  visible: description == null ? false : true,
                  child: DimenConstant.separator,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dueDate.toString(),
                      style: TextStyle(
                        fontSize: DimenConstant.miniTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    state == TaskState.upcoming
                        ? InkWell(
                            onTap: onCompleted,
                            child: Text('Mark as done'),
                          )
                        : Text(
                            state == TaskState.overdue
                                ? 'Task date ended'
                                : 'Completed',
                            style: TextStyle(
                              fontSize: DimenConstant.miniTextSize,
                              fontWeight: FontWeight.bold,
                            ),
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
