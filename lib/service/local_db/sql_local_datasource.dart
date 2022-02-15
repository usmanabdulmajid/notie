import 'package:notie/models/note.dart';
import 'package:notie/service/local_db/ilocal_datasource.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlLocalDatasource implements ILocalDatasource {
  Future<Database> _initializeDb() async {
    String path = join(await getDatabasesPath(), 'note_db');
    var noteDb = openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE note(noteId TEXT UNIQUE, userId TEXT, title TEXT, body TEXT, color INTEGER, noteType TEXT, date TEXT, audioPath TEXT)');
    });
    return noteDb;
  }

  late final database = _initializeDb();

  @override
  Future<bool> deleteNotes(List<String> noteIds) async {
    final db = await database;
    var result = await db.delete('note',
        where: 'noteId IN (${List.filled(noteIds.length, '?').join(',')})',
        whereArgs: noteIds);
    return result != 0;
  }

  @override
  Future<List<Note>> fetchNotes() async {
    final db = await database;
    List<Note> notes = [];
    List<Map<String, dynamic>> result = await db.query('note');
    notes = result.map((e) {
      return Note.fromMap(e);
    }).toList();
    return notes;
  }

  @override
  Future<bool> saveNote(Note note) async {
    final db = await database;
    var result = await db.insert('note', note.toMap());
    return result != 0;
  }

  @override
  Future<List<Note>> searchNotes(String title) async {
    final db = await database;
    List<Note> notes = [];
    List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT * FROM note  WHERE title LIKE ?', ['%$title%']);
    notes = result.map((e) {
      return Note.fromMap(e);
    }).toList();
    return notes;
  }

  @override
  Future<bool> updateNote(Note note) async {
    final db = await database;
    var result = await db.update('note', note.toMap(),
        where: 'noteId = ?',
        whereArgs: [note.noteId],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result != 0;
  }

  @override
  Future<Note> findbyNoteId(String noteId) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query('note', where: 'noteId =?', whereArgs: [noteId]);
    final note = Note.fromMap(result[0]);
    return note;
  }

  @override
  Future<List<Note>> fetchNoteWithUserId(String userId) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query('note', where: 'userId = ?', whereArgs: [userId]);
    final notes = result.map((e) => Note.fromMap(e)).toList();
    return notes;
  }

  @override
  Future<bool> resetNoteTable() async {
    final db = await database;
    final result = await db.delete('note', where: null);
    return result != 0;
  }
}
