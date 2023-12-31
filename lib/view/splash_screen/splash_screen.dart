import 'dart:async';

import 'package:flutter/material.dart';
import 'package:echo_note/utils/color_constant.dart';
import 'package:echo_note/view/home_screen/home_screen.dart';

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
      backgroundColor: ColorConstant.primaryColor,
      body: Center(
        child: Icon(
          Icons.notes,
          color: ColorConstant.tertiaryColor,
          size: MediaQuery.of(context).size.width / 2,
        ),
      ),
    );
  }
}
