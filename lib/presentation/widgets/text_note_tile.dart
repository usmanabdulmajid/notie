import 'package:flutter/material.dart';
import 'package:notie/application/cubit/notecubit_cubit.dart';
import 'package:notie/domain/models/note.dart';
import 'package:notie/presentation/screens/compose_note_screen.dart';
import 'package:notie/presentation/screens/read_note_screen.dart';
import 'package:notie/routes.dart';
import 'package:provider/src/provider.dart';

class TextNoteTile extends StatelessWidget {
  final Note note;
  final List<String>? selections;
  const TextNoteTile({required this.note, this.selections, Key? key})
      : super(key: key);
  bool get isSelected => selections!.contains(note.noteId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context.read<NotecubitCubit>().onLongPressedNote(note.noteId);
      },
      onTap: () {
        final response = context.read<NotecubitCubit>().proceedNavigation();
        if (response) {
          Navigator.pushNamed(context, Routes.readNote, arguments: note);
        } else {
          context.read<NotecubitCubit>().onPressedNote(note.noteId);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected
              ? const Color(0XFF264653).withOpacity(0.5)
              : Colors.transparent,
        ),
        padding: EdgeInsets.all(isSelected ? 8 : 4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(note.color).withOpacity(isSelected ? 0.7 : 1),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title!,
                maxLines: 1,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                note.body!,
                maxLines: 11,
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
