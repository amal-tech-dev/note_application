import 'dart:math';

import 'package:flutter/material.dart';

class NoteColorController {
  static List noteColors = [
    {
      'border': Colors.deepPurple,
      'background': Colors.deepPurpleAccent.shade100,
    },
    {
      'border': Colors.amber,
      'background': Colors.amberAccent.shade100,
    },
    {
      'border': Colors.blue,
      'background': Colors.blueAccent.shade100,
    },
    {
      'border': Colors.blueGrey,
      'background': Colors.blueGrey.shade200,
    },
    {
      'border': Colors.brown,
      'background': Colors.brown.shade200,
    },
    {
      'border': Colors.cyan,
      'background': Colors.cyanAccent.shade100,
    },
    {
      'border': Colors.deepOrange,
      'background': Colors.deepOrangeAccent.shade100,
    },
    {
      'border': Colors.indigo,
      'background': Colors.indigoAccent.shade200,
    },
    {
      'border': Colors.lightBlue,
      'background': Colors.lightBlueAccent.shade100,
    },
    {
      'border': Colors.lightGreen,
      'background': Colors.lightGreenAccent.shade100,
    },
    {
      'border': Colors.orange,
      'background': Colors.orangeAccent.shade100,
    },
    {
      'border': Colors.pink,
      'background': Colors.pinkAccent.shade100,
    },
    {
      'border': Colors.purple,
      'background': Colors.purpleAccent.shade100,
    },
    {
      'border': Colors.red,
      'background': Colors.redAccent.shade100,
    },
    {
      'border': Colors.green,
      'background': Colors.greenAccent.shade200,
    },
  ];

  Map randomNumber() {
    int randomIndex = Random().nextInt(noteColors.length);
    return noteColors[randomIndex];
  }
}
