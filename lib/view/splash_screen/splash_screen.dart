import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_application/utils/color_constant/color_constant.dart';
import 'package:note_application/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor.shade200,
      body: Center(
        child: Icon(
          Icons.notes,
          size: MediaQuery.of(context).size.width / 2,
        ),
      ),
    );
  }
}
