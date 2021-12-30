import 'package:notie/domain/enitities/note.dart';

abstract class ILocalDatasource {
  Future<bool> saveNote(Note note);
  Future<bool> updateNote(Note note);
  Future<bool> deleteNotes(List<String> ids);
  Future<List<Note>> fetchNotes();
  Future<List<Note>> searchNotes(String title);
}
