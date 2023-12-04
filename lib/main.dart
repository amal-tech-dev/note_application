import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/view/home_screen/home_screen.dart';
import 'package:note_application/view/note_view_screen/note_view_screen.dart';
import 'package:note_application/view/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('noteBox');
  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
