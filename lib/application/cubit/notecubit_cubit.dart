import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:notie/domain/models/note.dart';
import 'package:notie/infrastructure/repositories/inote_repository.dart';
import 'package:notie/utils/enums.dart';

part 'notecubit_state.dart';

class NotecubitCubit extends Cubit<NotecubitState> {
  final INoteRepository noteRepository;

  NotecubitCubit(this.noteRepository) : super(NotecubitInitial());

  Future<void> loadNotes() async {
    final notes = await noteRepository.load();
    emit(LoadNote(notes));
  }

  Future<void> saveNote(String title, String body, Color color) async {
    final date = DateFormat.yMMMd().format(DateTime.now());
    print('ban ${color.value}');
    Note note = Note(
      title: title,
      body: body,
      date: date,
      noteType: NoteType.text,
      color: color.value,
    );
    final result = await noteRepository.add(note);
    emit(SaveNote(result));
    if (result) {
      print('bankai');
      await loadNotes();
    }
  }

  Future<void> deleteNote(List<String> ids) async {
    final result = await noteRepository.delete(ids);
    emit(DeleteNote(result));
    if (result) {
      await loadNotes();
    }
  }

  Future<void> searchNotes(String title) async {
    final searchedNotes = await noteRepository.search(title);
    if (searchedNotes.isNotEmpty) {
      emit(LoadNote(searchedNotes));
    } else {}
  }

  Future<void> updateNote(Note note) async {
    final date = DateFormat.yMMMd().format(DateTime.now());
    note.copywith(date: date);
    final result = await noteRepository.update(note);
    if (result) {
      await loadNotes();
    }
  }
}
