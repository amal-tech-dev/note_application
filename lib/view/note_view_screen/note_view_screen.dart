import 'package:flutter/material.dart';
import 'package:note_application/controller/date_time_format_controller.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';

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
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            iconColor: ColorConstant.secondaryColor,
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
