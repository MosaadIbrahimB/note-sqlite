import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_sqlite/feature/note/presentation/screen/notes_screen.dart';

import 'feature/note/data/database/notes_database.dart';
import 'feature/note/presentation/logic/notes_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = NotesDatabase.instance;

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final NotesDatabase db;
  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      home: BlocProvider(
        create: (_) => NotesCubit(db),
        child: const NotesScreen(),
      ),
    );
  }
}
