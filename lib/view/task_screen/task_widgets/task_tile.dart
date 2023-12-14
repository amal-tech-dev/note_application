import 'package:flutter/material.dart';
import 'package:note_application/utils/dimen_constant.dart';

class TaskTile extends StatelessWidget {
  String title, description;
  DateTime dueDate;
  bool isOverDue, isDone;

  TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isOverDue,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOverDue
            ? Colors.red.shade50
            : isDone
                ? Colors.green.shade50
                : Colors.blue.shade50,
        border: Border.all(
          color: isOverDue
              ? Colors.red.shade500
              : isDone
                  ? Colors.green.shade500
                  : Colors.blue.shade500,
          width: DimenConstant.borderWidth,
        ),
        borderRadius: BorderRadius.circular(DimenConstant.borderRadius),
      ),
      child: ExpansionTile(
        title: Text(
          'Title',
          style: TextStyle(
            fontSize: DimenConstant.titleTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.edgePadding,
                ),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: DimenConstant.subTitleTextSize,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              DimenConstant.separator,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Text(
                      DateTime.now().toString(),
                      style: TextStyle(
                        fontSize: DimenConstant.miniTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Mark as done'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
