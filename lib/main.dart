import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_lite/bloc/notes_bloc.dart';
import 'package:sql_lite/bloc/notes_event.dart';
import 'package:sql_lite/view/notes_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc()..add(LoadNotes()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NotesScreen(),
      ),
    );
  }
}