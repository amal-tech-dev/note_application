import 'package:flutter/material.dart';
import 'package:note_application/controller/date_time_format_controller.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';

class NoteViewScreen extends StatelessWidget {
  String title, content;
  DateTime dateTime;
  VoidCallback onEditPressed, onDeletePressed;
  final dateTimeFormater = DateTimeFormatController();

  NoteViewScreen({
    super.key,
    required this.title,
    required this.content,
    required this.dateTime,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              dateTimeFormater.formatDateTime(dateTime),
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.miniTextSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
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
