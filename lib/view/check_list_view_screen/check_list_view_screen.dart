import 'package:flutter/material.dart';
import 'package:note_application/controller/date_time_format_controller.dart';
import 'package:note_application/model/list_model.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/view/check_list_view_screen/check_list_view_widgets/check_list_view_tile.dart';

class CheckListViewScreen extends StatelessWidget {
  String title;
  List<ContentModel> contentList;
  DateTime dateTime;
  VoidCallback onEditPressed, onDeletePressed;
  final dateTimeFormater = DateTimeFormatController();

  CheckListViewScreen({
    super.key,
    required this.title,
    required this.contentList,
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
      body: ListView.builder(
        itemBuilder: (context, index) => CheckListViewTile(
          item: contentList[index].item,
          isCheck: contentList[index].isMarked,
          onCheckboxPressed: (value) {},
        ),
        itemCount: contentList.length,
      ),
    );
  }
}
