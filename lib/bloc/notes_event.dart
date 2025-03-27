import 'package:sql_lite/model/model.dart';

abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final Note note;
  AddNote(this.note);
}

class DeleteNote extends NoteEvent {
  final int id;
  DeleteNote(this.id);
}
