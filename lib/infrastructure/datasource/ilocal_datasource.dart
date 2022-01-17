import 'package:notie/domain/models/note.dart';

abstract class ILocalDatasource {
  Future<bool> saveNote(Note note);
  Future<bool> updateNote(Note note);
  Future<bool> deleteNotes(List<int> ids);
  Future<List<Note>> fetchNotes();
  Future<List<Note>> searchNotes(String title);
}
