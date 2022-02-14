import 'package:notie/models/note.dart';

abstract class IRemoteDatabase {
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
  Future<List<Note>> loadNotes();
}
