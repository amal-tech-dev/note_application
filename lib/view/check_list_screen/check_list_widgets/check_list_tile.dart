import 'package:flutter/material.dart';
import 'package:note_application/controller/color_controller.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';

class CheckListTile extends StatelessWidget {
  CheckListTile({
    super.key,
    required this.title,
    required this.contentList,
    required this.dateTime,
    required this.onEditClicked,
    required this.onDeleteClicked,
  });

  String title;
  List<String> contentList;
  DateTime dateTime;
  VoidCallback onEditClicked, onDeleteClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: DimenConstant.edgePadding,
        bottom: DimenConstant.edgePadding,
      ),
      decoration: BoxDecoration(
        color: ColorController().randomColor(isTask: false),
        borderRadius: BorderRadius.circular(DimenConstant.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: ColorConstant.tertiaryColor,
                    fontSize: DimenConstant.titleTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Edit'),
                    onTap: onEditClicked,
                  ),
                  PopupMenuItem(
                    child: Text('Delete'),
                    onTap: onDeleteClicked,
                  ),
                ],
                color: ColorConstant.bgColor,
              ),
            ],
          ),
          Text(
            contentList.join('\n'),
            style: TextStyle(
              color: ColorConstant.tertiaryColor,
              fontSize: DimenConstant.subTitleTextSize,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
