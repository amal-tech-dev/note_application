import 'package:flutter/material.dart';
import 'package:note_application/utils/color_constant.dart';
import 'package:note_application/utils/dimen_constant.dart';

class CheckListViewTile extends StatelessWidget {
  String item;
  void Function(bool?)? onCheckboxPressed;

  CheckListViewTile({
    required this.item,
    required this.onCheckboxPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: DimenConstant.edgePadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: true,
            onChanged: onCheckboxPressed,
          ),
          DimenConstant.separator,
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                color: ColorConstant.tertiaryColor,
                fontSize: DimenConstant.subTitleTextSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
