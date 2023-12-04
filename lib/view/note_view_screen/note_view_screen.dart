import 'package:flutter/material.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';

class NoteViewScreen extends StatelessWidget {
  String title, content;
  VoidCallback onEditPressed, onDeletePressed;

  NoteViewScreen({
    super.key,
    required this.title,
    required this.content,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor.shade200,
        leading: BackButton(
          color: ColorConstant.secondaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: ColorConstant.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
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
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Expanded(
          child: Text(
            content,
            style: TextStyle(
              fontSize: 20,
            ),
            maxLines: 100,
          ),
        ),
      ),
    );
  }
}
