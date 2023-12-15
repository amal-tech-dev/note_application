import 'dart:math';

import 'package:flutter/material.dart';

class ColorController {
  List<Map<String, Color?>> noteColors = [
    {
      'border': Colors.amber.shade500,
      'background': Colors.amber.shade50,
    },
    {
      'border': Colors.blue.shade500,
      'background': Colors.blue.shade50,
    },
    {
      'border': Colors.blueGrey.shade500,
      'background': Colors.blueGrey.shade50,
    },
    {
      'border': Colors.brown.shade500,
      'background': Colors.brown.shade50,
    },
    {
      'border': Colors.cyan.shade500,
      'background': Colors.cyan.shade50,
    },
    {
      'border': Colors.deepOrange.shade500,
      'background': Colors.deepOrange.shade50,
    },
    {
      'border': Colors.deepPurple.shade500,
      'background': Colors.deepPurple.shade50,
    },
    {
      'border': Colors.green.shade500,
      'background': Colors.green.shade50,
    },
    {
      'border': Colors.grey.shade500,
      'background': Colors.grey.shade50,
    },
    {
      'border': Colors.indigo.shade500,
      'background': Colors.indigo.shade100,
    },
    {
      'border': Colors.lightBlue.shade500,
      'background': Colors.lightBlue.shade50,
    },
    {
      'border': Colors.lightGreen.shade500,
      'background': Colors.lightGreen.shade50,
    },
    {
      'border': Colors.lime.shade500,
      'background': Colors.lime.shade50,
    },
    {
      'border': Colors.orange.shade500,
      'background': Colors.orange.shade50,
    },
    {
      'border': Colors.pink.shade500,
      'background': Colors.pink.shade50,
    },
    {
      'border': Colors.purple.shade500,
      'background': Colors.purple.shade50,
    },
    {
      'border': Colors.red.shade500,
      'background': Colors.red.shade50,
    },
    {
      'border': Colors.teal.shade500,
      'background': Colors.teal.shade50,
    },
    {
      'border': Colors.yellow.shade500,
      'background': Colors.yellow.shade50,
    },
  ];

  List<Map<String, Color?>> listColors = [
    {
      'border': Colors.amberAccent.shade400,
      'background': Colors.amberAccent.shade100,
    },
    {
      'border': Colors.blueAccent.shade400,
      'background': Colors.blueAccent.shade100,
    },
    {
      'border': Colors.cyanAccent.shade400,
      'background': Colors.cyanAccent.shade100,
    },
    {
      'border': Colors.deepOrangeAccent.shade400,
      'background': Colors.deepOrangeAccent.shade100,
    },
    {
      'border': Colors.deepPurpleAccent.shade400,
      'background': Colors.deepPurpleAccent.shade100,
    },
    {
      'border': Colors.greenAccent.shade400,
      'background': Colors.greenAccent.shade100,
    },
    {
      'border': Colors.indigoAccent.shade400,
      'background': Colors.indigoAccent.shade100,
    },
    {
      'border': Colors.lightBlueAccent.shade400,
      'background': Colors.lightBlueAccent.shade100,
    },
    {
      'border': Colors.lightGreenAccent.shade400,
      'background': Colors.lightGreenAccent.shade100,
    },
    {
      'border': Colors.limeAccent.shade400,
      'background': Colors.limeAccent.shade100,
    },
    {
      'border': Colors.orangeAccent.shade400,
      'background': Colors.orangeAccent.shade100,
    },
    {
      'border': Colors.pinkAccent.shade400,
      'background': Colors.pinkAccent.shade100,
    },
    {
      'border': Colors.purpleAccent.shade400,
      'background': Colors.purpleAccent.shade100,
    },
    {
      'border': Colors.redAccent.shade400,
      'background': Colors.redAccent.shade100,
    },
    {
      'border': Colors.tealAccent.shade400,
      'background': Colors.tealAccent.shade100,
    },
    {
      'border': Colors.yellowAccent.shade400,
      'background': Colors.yellowAccent.shade100,
    },
  ];

  Map<String, Map<String, Color?>> taskColors = {
    'red': {
      'border': Colors.red.shade500,
      'background': Colors.red.shade50,
    },
    'green': {
      'border': Colors.green.shade500,
      'background': Colors.green.shade50,
    },
    'blue': {
      'border': Colors.blue.shade500,
      'background': Colors.blue.shade50,
    },
  };

  Map<String, Color?> randomColor({required bool isNote}) {
    int randomIndex =
        Random().nextInt(isNote ? noteColors.length : listColors.length);
    return isNote ? noteColors[randomIndex] : listColors[randomIndex];
  }
}
