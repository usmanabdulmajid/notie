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

  NotecubitCubit(this.noteRepository) : super(NoteLoading());
  bool noteSelection = false;
  List<int> selectedNoteId = [];
  Map<int, bool> selectionMap = <int, bool>{};

  Future<void> loadNotes() async {
    final notes = await noteRepository.load();
    emit(LoadNote(notes));
  }

  Future<void> saveNote(Note note) async {
    final result = await noteRepository.add(note);
    emit(SaveNote(result));
    if (result) {
      await loadNotes();
    }
  }

  Future<void> deleteNote() async {
    if (selectedNoteId.isNotEmpty) {
      final result = await noteRepository.delete(selectedNoteId);
      emit(DeleteNote(result));
      if (result) {
        await loadNotes();
      }
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
    emit(UpdateNote(result));
    if (result) {
      await loadNotes();
    }
  }

  void onPressedNote(int id) {
    if (noteSelection) {
      selectionMap[id] = true;
    }
    if (selectionMap.containsKey(id)) {
      selectionMap[id] = false;
    }
  }

  void onLongPressedNote(int id) {
    if (!noteSelection) {
      noteSelection = true;
      selectionMap[id] = true;
    }
  }
}
