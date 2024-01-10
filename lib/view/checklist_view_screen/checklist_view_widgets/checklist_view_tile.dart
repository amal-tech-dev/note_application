import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/utils/dimen_constant.dart';
import 'package:flutter/material.dart';

class ChecklistViewTile extends StatelessWidget {
  String item;
  bool isCheck;
  void Function(bool?)? onCheckboxPressed;

  ChecklistViewTile({
    required this.item,
    required this.isCheck,
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
            value: isCheck,
            onChanged: onCheckboxPressed,
          ),
          DimenConstant.separator,
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.subTitleTextSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
