import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notie/models/note.dart';
import 'package:notie/service/auth/firebase_authentication.dart';
import 'package:notie/service/remote_db/iremote_database.dart';
import 'package:notie/injection_container.dart';

class FirestoreDatabase implements IRemoteDatabase {
  final CollectionReference collection;
  FirestoreDatabase(this.collection);
  @override
  Future<bool> addNote(Note note) async {
    bool result;
    try {
      result = await collection.doc(note.noteId).set({
        'userId': sl<FirebaseAuthImp>().userId(),
        ...note.toMap()
      }).then((value) {
        return true;
      });
    } catch (e) {
      print(e);
      result = false;
    }
    return result;
  }

  @override
  Future<void> deleteNote(String noteId) async {
    try {
      await collection.doc(noteId).delete();
    } catch (e) {
      print('delete err0r $e');
    }
  }

  @override
  Future<List<Note>> loadNotes() async {
    List<Note> notes = [];
    try {
      notes = await collection
          .where('userId', isEqualTo: sl<FirebaseAuthImp>().userId())
          .get()
          .then((value) => value.docs
              .map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      print(e);
    }

    return notes;
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      await collection.doc(note.noteId).update(note.toMap());
    } catch (e) {
      print('$e');
    }
  }
}
