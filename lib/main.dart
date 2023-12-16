import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/controller/check_list_controller.dart';
import 'package:note_application/controller/floating_button_controller.dart';
import 'package:note_application/model/list_model.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/model/task_model.dart';
import 'package:note_application/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

enum TaskState { overdue, completed, upcoming }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(CheckListModelAdapter());
  Hive.registerAdapter(ContentModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());

  await Hive.openBox<NoteModel>('noteBox');
  await Hive.openBox<CheckListModel>('checkListBox');
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
        ChangeNotifierProvider(create: (context) => CheckListController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
