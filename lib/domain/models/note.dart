import 'dart:ui';

import 'package:notie/utils/enums.dart';

class Note {
  String? id;
  String? title;
  String? body;
  Color? color;
  NoteType? noteType;
  DateTime? date;

  Note({
    this.id,
    this.title,
    this.body,
    this.color,
    this.noteType,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'color': color,
      'noteType': noteType!.name,
      'date': date,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      color: map['color'],
      noteType: ParseNoteType.fromString(map['noteType']),
      date: map['date'],
    );
  }

  Note copywith(String? id, String? title, String? body, Color? color,
      NoteType? noteType, DateTime? date) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      color: color ?? this.color,
      noteType: noteType ?? this.noteType,
      date: date ?? this.date,
    );
  }
}
