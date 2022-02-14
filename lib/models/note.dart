import 'package:notie/utils/enums.dart';

class Note {
  int? id;
  String? title;
  String? body;
  String? audioPath;
  String? userId;
  String noteId;
  int color;
  NoteType noteType;
  String date;

  Note({
    this.id,
    this.title,
    this.body,
    this.audioPath,
    this.userId,
    required this.noteId,
    required this.color,
    required this.noteType,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'title': title,
      'body': body,
      'audioPath': audioPath,
      'userId': userId,
      'noteId': noteId,
      'color': color,
      'noteType': noteType.name,
      'date': date,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      audioPath: map['audioPath'],
      userId: map['userId'],
      noteId: map['noteId'],
      color: map['color'],
      noteType: ParseNoteType.fromString(map['noteType']),
      date: map['date'],
    );
  }

  Note copywith(
      {int? id,
      String? title,
      String? body,
      String? audioPath,
      String? noteId,
      int? color,
      NoteType? noteType,
      String? date}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      audioPath: audioPath ?? this.audioPath,
      noteId: noteId ?? this.noteId,
      color: color ?? this.color,
      noteType: noteType ?? this.noteType,
      date: date ?? this.date,
    );
  }
}
