import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  NoteTile({
    super.key,
    required this.title,
    required this.content,
    required this.colorIndex,
    required this.onEditClicked,
    required this.onDeleteClicked,
  });

  String title, content;
  int colorIndex;
  VoidCallback onEditClicked, onDeleteClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: DimenConstant.edgePadding,
        bottom: DimenConstant.edgePadding,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.colorsList[colorIndex]!,
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
                    color: ColorConstant.secondaryColor,
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
          Padding(
            padding: const EdgeInsets.only(
              right: DimenConstant.edgePadding,
            ),
            child: Text(
              content,
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.subTitleTextSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
