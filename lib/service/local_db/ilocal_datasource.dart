import 'package:notie/models/note.dart';

abstract class ILocalDatasource {
  Future<bool> saveNote(Note note);
  Future<bool> updateNote(Note note);
  Future<bool> deleteNotes(List<String> noteIds);
  Future<List<Note>> fetchNotes();
  Future<List<Note>> searchNotes(String title);
  Future<Note> findbyNoteId(String noteId);
  Future<List<Note>> fetchNoteWithUserId(String userId);
  Future<List<Note>> searchNoteByUserId(String title, String userId);
  Future<bool> resetNoteTable();
}
