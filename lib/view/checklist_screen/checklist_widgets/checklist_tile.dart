import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:flutter/material.dart';

class ChecklistTile extends StatelessWidget {
  ChecklistTile({
    super.key,
    required this.title,
    required this.contentList,
    required this.colorIndex,
    required this.onEditClicked,
    required this.onDeleteClicked,
  });

  String title;
  List<String> contentList;
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
        color: ColorConstant.tertiaryColor,
        borderRadius: BorderRadius.circular(
          DimenConstant.borderRadius,
        ),
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
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.titleTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                    onTap: onEditClicked,
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                    onTap: onDeleteClicked,
                  ),
                ],
              ),
            ],
          ),
          Text(
            contentList.join('\n'),
            style: TextStyle(
              color: ColorConstant.primaryColor,
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
