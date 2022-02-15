import 'package:notie/models/note.dart';
import 'package:notie/repositories/inote_repository.dart';
import 'package:notie/service/auth/firebase_authentication.dart';
import 'package:notie/service/local_db/ilocal_datasource.dart';
import 'package:notie/service/remote_db/iremote_database.dart';
import 'package:notie/injection_container.dart';
import 'package:share_plus/share_plus.dart';

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
    final result = await localDatasource.saveNote(note);
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

  @override
  Future<void> shareNote(String noteId) async {
    Note note = await localDatasource.findbyNoteId(noteId);
    note.title ??= '';
    note.body ??= '';
    Share.share(note.title! + '\n' + note.body!);
  }

  @override
  Future<List<Note>> loadByUserId(String userId) async {
    var notes = await remoteDatabase.loadNotes();
    for (var note in notes) {
      localDatasource.saveNote(note);
    }
    notes = await localDatasource.fetchNoteWithUserId(userId);

    return notes;
  }

  @override
  Future<void> resetTable() async {
    await localDatasource.resetNoteTable();
  }
}
