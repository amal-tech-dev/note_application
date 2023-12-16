import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_application/main.dart';

class ColorController {
  List<Color?> colors = [
    Colors.grey.shade400,
    Colors.amber.shade200,
    Colors.blue.shade200,
    Colors.blueGrey.shade200,
    Colors.brown.shade200,
    Colors.cyan.shade200,
    Colors.deepOrange.shade200,
    Colors.deepPurple.shade200,
    Colors.green.shade200,
    Colors.indigo.shade200,
    Colors.lightBlue.shade200,
    Colors.lightGreen.shade200,
    Colors.lime.shade200,
    Colors.orange.shade200,
    Colors.pink.shade200,
    Colors.purple.shade200,
    Colors.red.shade200,
    Colors.teal.shade200,
    Colors.yellow.shade200,
    Colors.amberAccent.shade100,
    Colors.blueAccent.shade100,
    Colors.cyanAccent.shade100,
    Colors.deepOrangeAccent.shade100,
    Colors.deepPurpleAccent.shade100,
    Colors.greenAccent.shade100,
    Colors.indigoAccent.shade100,
    Colors.lightBlueAccent.shade100,
    Colors.lightGreenAccent.shade100,
    Colors.limeAccent.shade100,
    Colors.orangeAccent.shade100,
    Colors.pinkAccent.shade100,
    Colors.purpleAccent.shade100,
    Colors.redAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.yellowAccent.shade100,
  ];

  Color? randomColor({required bool isTask, TaskState? taskState}) {
    int randomIndex = Random().nextInt(colors.length);
    if (isTask) {
      switch (taskState!) {
        case TaskState.overdue:
          return Colors.red.shade200;
        case TaskState.completed:
          return Colors.green.shade200;
        case TaskState.upcoming:
          return Colors.blue.shade200;
      }
    } else {
      return colors[randomIndex];
    }
  }
}
