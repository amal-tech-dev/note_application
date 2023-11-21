import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  NoteTile({
    super.key,
    required this.title,
    required this.content,
    required this.noteColor,
    required this.onEditClicked,
    required this.onDeleteClicked,
  });
  String title, content;
  Color noteColor;
  var onEditClicked, onDeleteClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: noteColor,
        borderRadius: BorderRadius.circular(15),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: onEditClicked,
                icon: Icon(
                  Icons.edit,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: onDeleteClicked,
                icon: Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            content,
            style: TextStyle(
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
