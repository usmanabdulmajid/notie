import 'package:flutter/material.dart';
import 'package:notie/domain/models/note.dart';

class AudioNoteTile extends StatelessWidget {
  final Note note;
  const AudioNoteTile({required this.note, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Card(
        color: Color(note.color),
        child: Column(
          children: [Text(note.title!), Text(note.audioPath!)],
        ),
      ),
    );
  }
}
