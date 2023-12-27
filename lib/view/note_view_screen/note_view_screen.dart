import 'package:flutter/material.dart';
import 'package:echo_note/controller/date_controller.dart';
import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';

class NoteViewScreen extends StatelessWidget {
  String title, content;
  int colorIndex;
  VoidCallback onEditPressed, onDeletePressed;
  DateController dateTimeFormater = DateController();

  NoteViewScreen({
    super.key,
    required this.title,
    required this.content,
    required this.colorIndex,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
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
          IconButton(
            onPressed: onEditPressed,
            icon: Icon(
              Icons.edit_rounded,
              color: ColorConstant.secondaryColor,
            ),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: Icon(
              Icons.delete_rounded,
              color: ColorConstant.secondaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(DimenConstant.edgePadding),
          child: Text(
            content,
            style: TextStyle(
              color: ColorConstant.tertiaryColor,
              fontSize: DimenConstant.titleTextSize,
            ),
            maxLines: 100,
          ),
        ),
      ),
    );
  }
}
