import 'package:flutter/material.dart';
import 'package:notie/application/cubit/notecubit_cubit.dart';
import 'package:notie/domain/models/note.dart';
import 'package:notie/presentation/screens/compose_note_screen.dart';
import 'package:notie/presentation/screens/read_note_screen.dart';
import 'package:notie/routes.dart';
import 'package:provider/src/provider.dart';

class TextNoteTile extends StatelessWidget {
  final Note note;
  const TextNoteTile({required this.note, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context.read<NotecubitCubit>().onLongPressedNote(note.id!);
      },
      onTap: () {
        final response = context.read<NotecubitCubit>().proceedNavigation();
        if (response) {
          Navigator.pushNamed(context, Routes.readNote, arguments: note);
        } else {
          context.read<NotecubitCubit>().onPressedNote(note.id!);
        }
      },
      child: Card(
        color: Color(note.color),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title!,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                note.body!,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(height: 1.5),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.upload,
                      size: 12.0,
                    ),
                    Text(note.date)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
