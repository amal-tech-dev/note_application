import 'package:flutter/material.dart';
import 'package:note_application/view/home_screen/home_screen.dart';
import 'package:note_application/view/login_screen/login_screen.dart';
import 'package:note_application/view/sigup_screen/signup_screen.dart';
import 'package:note_application/view/splash_screen/splash_screen.dart';

void main() => runApp(NoteApp());

class NoteApp extends StatelessWidget {
  NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
