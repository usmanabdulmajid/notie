import 'package:notie/domain/models/note.dart';
import 'package:notie/infrastructure/datasource/ilocal_datasource.dart';
import 'package:notie/infrastructure/repositories/inote_repository.dart';

class NoteRepository implements INoteRepository {
  final ILocalDatasource localDatasource;
  NoteRepository(this.localDatasource);
  @override
  Future<bool> add(Note note) async {
    final result = localDatasource.saveNote(note);
    return result;
  }

  @override
  Future<bool> delete(List<int> ids) async {
    final result = await localDatasource.deleteNotes(ids);
    return result;
  }

  @override
  Future<List<Note>> load() async {
    final notes = await localDatasource.fetchNotes();
    return notes;
  }

  @override
  Future<List<Note>> search(String title) async {
    final searchednotes = await localDatasource.searchNotes(title);
    return searchednotes;
  }

  @override
  Future<bool> update(Note note) async {
    final result = await localDatasource.updateNote(note);
    return result;
  }
}
