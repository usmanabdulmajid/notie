import 'package:notie/application/usecases/firebase_authentication.dart';
import 'package:notie/domain/models/note.dart';
import 'package:notie/domain/usecases/iremote_database.dart';
import 'package:notie/infrastructure/datasource/ilocal_datasource.dart';
import 'package:notie/infrastructure/repositories/inote_repository.dart';
import 'package:notie/injection_container.dart';

class NoteRepository implements INoteRepository {
  final ILocalDatasource localDatasource;
  final IRemoteDatabase remoteDatabase;
  NoteRepository({
    required this.localDatasource,
    required this.remoteDatabase,
  });
  @override
  Future<bool> add(Note note) async {
    if (sl<FirebaseAuthImp>().userId() != null) {
      remoteDatabase.addNote(note);
    }
    final result = localDatasource.saveNote(note);
    return result;
  }

  @override
  Future<bool> delete(List<String> noteIds) async {
    if (sl<FirebaseAuthImp>().userId() != null) {
      for (var noteId in noteIds) {
        remoteDatabase.deleteNote(noteId);
      }
    }
    final result = await localDatasource.deleteNotes(noteIds);
    return result;
  }

  @override
  Future<List<Note>> load() async {
    if (sl<FirebaseAuthImp>().userId() != null) {
      final notes = await remoteDatabase.loadNotes();
      for (var note in notes) {
        await localDatasource.saveNote(note);
      }
    }
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
    if (sl<FirebaseAuthImp>().userId() != null) {
      remoteDatabase.updateNote(note);
    }
    final result = await localDatasource.updateNote(note);
    return result;
  }
}
