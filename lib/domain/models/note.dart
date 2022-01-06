import 'dart:ui';

import 'package:notie/utils/enums.dart';

class Note {
  int? id;
  String? title;
  String? body;
  int color;
  NoteType noteType;
  String date;

  Note({
    this.id,
    this.title,
    this.body,
    required this.color,
    required this.noteType,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'color': color,
      'noteType': noteType.name,
      'date': date,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    print('shikai ${map['color']}');
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      color: map['color'],
      noteType: ParseNoteType.fromString(map['noteType']),
      date: map['date'],
    );
  }

  Note copywith(
      {int? id,
      String? title,
      String? body,
      int? color,
      NoteType? noteType,
      String? date}) {
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
