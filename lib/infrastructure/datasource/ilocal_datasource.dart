import 'package:notie/domain/models/note.dart';

abstract class ILocalDatasource {
  Future<bool> saveNote(Note note);
  Future<bool> updateNote(Note note);
  Future<bool> deleteNotes(List<String> noteIds);
  Future<List<Note>> fetchNotes();
  Future<List<Note>> searchNotes(String title);
  Future<Note> findbyNoteId(String noteId);
}
