import 'package:sql_lite/bloc/notes_event.dart';
import 'package:sql_lite/bloc/notes_state.dart';
import 'package:sql_lite/handler/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  NoteBloc() : super(NotesLoading()) {
    on<LoadNotes>((event, emit) async {
      final notes = await dbHelper.getNotes();
      emit(NotesLoaded(notes));
    });

    on<AddNote>((event, emit) async {
      await dbHelper.insert(event.note);
      final notes = await dbHelper.getNotes();
      emit(NotesLoaded(notes));
    });

    on<DeleteNote>((event, emit) async {
      await dbHelper.delete(event.id);
      final notes = await dbHelper.getNotes();
      emit(NotesLoaded(notes));
    });
  }
}
