import 'package:flutter/material.dart';
import 'package:note_application/controller/note_color_controller.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';

class CheckboxListTile extends StatelessWidget {
  CheckboxListTile({
    super.key,
    required this.title,
    required this.content,
    required this.onEditClicked,
    required this.onDeleteClicked,
  });
  String title, content;
  VoidCallback onEditClicked, onDeleteClicked;
  final randomColorController = NoteColorController();

  @override
  Widget build(BuildContext context) {
    final randomColor = randomColorController.randomNumber();
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: randomColor['background'],
        borderRadius: BorderRadius.circular(7.5),
        border: Border.all(
          color: randomColor['border'],
          width: 3,
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
                    fontSize: 20,
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
              fontSize: 15,
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
