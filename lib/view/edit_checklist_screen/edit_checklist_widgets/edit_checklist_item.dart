import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:flutter/material.dart';

class EditCheckListItem extends StatelessWidget {
  EditCheckListItem({
    super.key,
    required this.itemName,
    required this.onClearPressed,
  });

  final String itemName;
  VoidCallback onClearPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        DimenConstant.edgePadding,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.tertiaryColor,
        borderRadius: BorderRadius.circular(
          DimenConstant.borderRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              itemName,
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.titleTextSize,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: onClearPressed,
            child: Icon(
              Icons.remove_rounded,
              size: 30,
              color: ColorConstant.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
