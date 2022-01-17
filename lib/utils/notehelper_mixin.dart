import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:notie/domain/models/note.dart';
import 'package:notie/utils/enums.dart';

mixin HelperMixin {
  bool nonEmptyNote(String title, String body, String audioPath) {
    return title.isNotEmpty && body.isNotEmpty && audioPath.isNotEmpty;
  }

  Color noteColor() {
    List<Color> colors = const [
      Color(0XFFE05D5D),
      Color(0XFFFFF8E5),
      Color(0XFFFFB344),
      Color(0XFF00A19D),
      Color(0XFFFF6F06)
    ];
    int random = Random().nextInt(colors.length);
    return colors[random];
  }

  Note setNote({
    required NoteType noteType,
    String? title,
    String? body,
    String? audioPath,
  }) {
    final date = DateFormat.yMMMd().format(DateTime.now());
    Note note = Note(color: noteColor().value, noteType: noteType, date: date);
    if (noteType == NoteType.text) {
      note.title = title;
      note.body = body;
    } else {
      final time = DateTime.now();
      note.title ??= 'voice note';
      note.audioPath = audioPath! + '/$time';
    }

    return note;
  }
}
