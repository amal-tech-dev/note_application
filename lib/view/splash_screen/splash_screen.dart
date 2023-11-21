import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_application/view/home_screen/home_screen.dart';
import 'package:note_application/view/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final isLogged = prefs.getBool('isLoggedIn');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (isLogged != null && isLogged) ? HomeScreen() : LoginScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade200,
      body: Center(
        child: Icon(
          Icons.notes,
          size: MediaQuery.of(context).size.width / 2,
        ),
      ),
    );
  }
}
