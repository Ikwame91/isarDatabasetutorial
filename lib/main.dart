import 'package:flutter/material.dart';
import 'package:isarbase_tutorial/models/note_database.dart';
import 'package:isarbase_tutorial/pages/notespage.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase().initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => NoteDatabase()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NotesPage(),
    );
  }
}
