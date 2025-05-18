import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/database/notes_database.dart';
import '../../data/models/note.dart';

class NotesCubit extends Cubit<List<Note>> {
  final NotesDatabase db;

  NotesCubit(this.db) : super([]) {
    loadNotes();
  }

  Future<void> loadNotes() async {
    final notes = await db.readAllNotes();
    emit(notes);
  }

  Future<void> addNote(Note note) async {
    final newNote = await db.create(note);
    emit([...state, newNote]);
  }

  Future<void> updateNote(Note note) async {
    await db.update(note);
    final updatedNotes = state.map((n) => n.id == note.id ? note : n).toList();
    emit(updatedNotes);
  }

  Future<void> deleteNote(int id) async {
    await db.delete(id);
    final filteredNotes = state.where((note) => note.id != id).toList();
    emit(filteredNotes);
  }
}
