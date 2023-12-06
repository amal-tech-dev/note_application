import 'package:flutter/material.dart';
import 'package:note_application/utils/color_constant.dart';

class EditListItem extends StatelessWidget {
  EditListItem({
    super.key,
    required this.itemName,
    required this.onClearPressed,
  });

  final String itemName;
  VoidCallback onClearPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              itemName,
              style: TextStyle(
                color: ColorConstant.tertiaryColor,
                fontSize: 20,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: onClearPressed,
            icon: Icon(
              Icons.close_rounded,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
