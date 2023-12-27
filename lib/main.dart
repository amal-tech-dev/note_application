import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:echo_note/controller/checklist_controller.dart';
import 'package:echo_note/controller/floating_button_controller.dart';
import 'package:echo_note/controller/tab_index_controller.dart';
import 'package:echo_note/model/checklist_model.dart';
import 'package:echo_note/model/text_model.dart';
import 'package:echo_note/model/task_model.dart';
import 'package:echo_note/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

enum NoteType { text, checklist, task }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TextModelAdapter());
  Hive.registerAdapter(ChecklistModelAdapter());
  Hive.registerAdapter(ContentModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(TaskStateAdapter());

  await Hive.openBox<TextModel>('textBox');
  await Hive.openBox<ChecklistModel>('checklistBox');
  await Hive.openBox<TaskModel>('taskBox');

  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FloatingButtonController()),
        ChangeNotifierProvider(create: (context) => ChecklistController()),
        ChangeNotifierProvider(create: (context) => TabIndexController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
