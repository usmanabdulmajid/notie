import 'package:notie/models/note.dart';

abstract class IRemoteDatabase {
  Future<bool> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
  Future<List<Note>> loadNotes();
}
