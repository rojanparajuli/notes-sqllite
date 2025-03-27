import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sql_lite/bloc/notes_bloc.dart';
import 'package:sql_lite/bloc/notes_event.dart';
import 'package:sql_lite/bloc/notes_state.dart';
import 'package:sql_lite/components/colors.dart';
import 'package:sql_lite/view/add_notes.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Appcolor.primaryColor,
          centerTitle: true,
          elevation: 4,
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NotesLoaded) {
              if (state.notes.isEmpty) {
                return Center(
                  child: Text(
                    'No notes available',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      title: Text(
                        note.text,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: note.imagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(note.imagePath!),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.note, size: 40, color: Colors.grey),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          context.read<NoteBloc>().add(DeleteNote(note.id!));
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Appcolor.primaryColor,
          child: const Icon(Icons.add, size: 28, color: Colors.white),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNoteScreen()),
            );
            if (result == true) {
              // ignore: use_build_context_synchronously
              context.read<NoteBloc>().add(LoadNotes());
            }
          },
        ),
      ),
    );
  }
}
