import 'dart:io';

import 'package:notie/domain/models/note.dart';
import 'package:notie/infrastructure/datasource/ilocal_datasource.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlLocalDatasource implements ILocalDatasource {
  Future<Database> _initializeDb() async {
    String path = join(await getDatabasesPath(), 'note_db');
    var noteDb = openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT, body TEXT, color INTEGER, noteType TEXT, date TEXT, audioPath TEXT)');
    });
    return noteDb;
  }

  late final database = _initializeDb();

  @override
  Future<bool> deleteNotes(List<int> ids) async {
    final db = await database;
    var result = await db.delete('note', where: '$ids = ?', whereArgs: ids);
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
    var result = await db
        .update('note', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    return result != 0;
  }
}
