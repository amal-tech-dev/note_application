import 'dart:math';
import 'package:flutter/material.dart';
import 'package:note_application/utils/color_constant.dart';

class ColorController {
  List<Map> randomColors = [
    {
      'border': Colors.amber.shade900,
      'background': Colors.amber.shade100,
    },
    {
      'border': Colors.amberAccent.shade700,
      'background': Colors.amberAccent.shade100,
    },
    {
      'border': Colors.blue.shade900,
      'background': Colors.blue.shade100,
    },
    {
      'border': Colors.blueAccent.shade700,
      'background': Colors.blueAccent.shade100,
    },
    {
      'border': Colors.blueGrey.shade900,
      'background': Colors.blueGrey.shade100,
    },
    {
      'border': Colors.brown.shade900,
      'background': Colors.brown.shade100,
    },
    {
      'border': Colors.cyan.shade900,
      'background': Colors.cyan.shade100,
    },
    {
      'border': Colors.cyanAccent.shade700,
      'background': Colors.cyanAccent.shade100,
    },
    {
      'border': Colors.deepOrange.shade900,
      'background': Colors.deepOrange.shade100,
    },
    {
      'border': Colors.deepOrangeAccent.shade700,
      'background': Colors.deepOrangeAccent.shade100,
    },
    {
      'border': Colors.deepPurple.shade900,
      'background': Colors.deepPurple.shade100,
    },
    {
      'border': Colors.deepPurpleAccent.shade700,
      'background': Colors.deepPurpleAccent.shade100,
    },
    {
      'border': Colors.green.shade900,
      'background': Colors.green.shade100,
    },
    {
      'border': Colors.greenAccent.shade700,
      'background': Colors.greenAccent.shade100,
    },
    {
      'border': Colors.grey.shade900,
      'background': Colors.grey.shade100,
    },
    {
      'border': Colors.indigo.shade900,
      'background': Colors.indigo.shade100,
    },
    {
      'border': Colors.indigoAccent.shade700,
      'background': Colors.indigoAccent.shade100,
    },
    {
      'border': Colors.lightBlue.shade900,
      'background': Colors.lightBlue.shade100,
    },
    {
      'border': Colors.lightBlueAccent.shade700,
      'background': Colors.lightBlueAccent.shade100,
    },
    {
      'border': Colors.lightGreen.shade900,
      'background': Colors.lightGreen.shade100,
    },
    {
      'border': Colors.lightGreenAccent.shade700,
      'background': Colors.lightGreenAccent.shade100,
    },
    {
      'border': Colors.lime.shade900,
      'background': Colors.lime.shade100,
    },
    {
      'border': Colors.limeAccent.shade700,
      'background': Colors.limeAccent.shade100,
    },
    {
      'border': Colors.orange.shade900,
      'background': Colors.orange.shade100,
    },
    {
      'border': Colors.orangeAccent.shade700,
      'background': Colors.orangeAccent.shade100,
    },
    {
      'border': Colors.pink.shade900,
      'background': Colors.pink.shade100,
    },
    {
      'border': Colors.pinkAccent.shade700,
      'background': Colors.pinkAccent.shade100,
    },
    {
      'border': Colors.purple.shade900,
      'background': Colors.purple.shade100,
    },
    {
      'border': Colors.purpleAccent.shade700,
      'background': Colors.purpleAccent.shade100,
    },
    {
      'border': Colors.red.shade900,
      'background': Colors.red.shade100,
    },
    {
      'border': Colors.redAccent.shade700,
      'background': Colors.redAccent.shade100,
    },
    {
      'border': Colors.teal.shade900,
      'background': Colors.teal.shade100,
    },
    {
      'border': Colors.tealAccent.shade700,
      'background': Colors.tealAccent.shade100,
    },
    {
      'border': Colors.yellow.shade900,
      'background': Colors.yellow.shade100,
    },
    {
      'border': Colors.yellowAccent.shade700,
      'background': Colors.yellowAccent.shade100,
    },
  ];

  Map randomColor() {
    int randomIndex = Random().nextInt(randomColors.length);
    return randomColors[randomIndex];
  }
}
