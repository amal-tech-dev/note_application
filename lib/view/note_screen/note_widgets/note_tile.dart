import 'package:flutter/material.dart';
import 'package:note_application/controller/color_controller.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';

class NoteTile extends StatelessWidget {
  NoteTile({
    super.key,
    required this.title,
    required this.content,
    required this.onEditClicked,
    required this.onDeleteClicked,
  });
  String title, content;
  VoidCallback onEditClicked, onDeleteClicked;
  final randomColorController = ColorController();

  @override
  Widget build(BuildContext context) {
    final randomColor = randomColorController.randomColor(isNote: true);
    return Container(
      padding: EdgeInsets.only(
        left: DimenConstant.edgePadding,
        bottom: DimenConstant.edgePadding,
      ),
      decoration: BoxDecoration(
        color: randomColor['background']!,
        borderRadius: BorderRadius.circular(DimenConstant.borderRadius),
        border: Border.all(
          color: randomColor['border']!,
          width: DimenConstant.borderWidth,
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
            content,
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
