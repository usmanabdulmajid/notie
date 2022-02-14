import 'package:notie/models/note.dart';

abstract class INoteRepository {
  Future<bool> add(Note note);
  Future<bool> update(Note note);
  Future<List<Note>> load();
  Future<List<Note>> search(String title);
  Future<bool> delete(List<String> ids);
  Future<void> shareNote(String noteId);
  Future<List<Note>> loadByUserId(String userId);
  Future<void> resetTable();
}
