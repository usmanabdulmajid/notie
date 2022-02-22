import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:notie/models/note.dart';
import 'package:notie/common/utils/enums.dart';
import 'package:uuid/uuid.dart';

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
      Color(0XFFFF6F06),
      Color(0XFFF4A261),
      Color(0XFF2A9D8F),
      Color(0XFF264653),
      Color(0XFFE76F51),
      Color(0XFFE9C46A),
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
    Uuid uuid = const Uuid();
    final date = DateFormat.yMMMd().format(DateTime.now());
    Note note = Note(
      color: noteColor().value,
      noteType: noteType,
      date: date,
      noteId: uuid.v4(),
    );
    if (noteType == NoteType.text) {
      note.title = title;
      note.body = body;
    } else {
      note.title ??= 'voice note';
    }

    return note;
  }
}
