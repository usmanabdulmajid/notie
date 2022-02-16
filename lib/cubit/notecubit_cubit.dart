import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:notie/models/note.dart';
import 'package:notie/repositories/inote_repository.dart';
import 'package:notie/service/auth/firebase_authentication.dart';
import 'package:notie/injection_container.dart';

part 'notecubit_state.dart';

class NotecubitCubit extends Cubit<NotecubitState> {
  final INoteRepository noteRepository;

  NotecubitCubit(this.noteRepository) : super(NoteLoading());
  bool noteSelection = false;
  List<String> selectedNoteId = [];

  Future<void> loadNotes() async {
    emit(NoteLoading());
    if (sl<FirebaseAuthImp>().userId() != null) {
      final notes =
          await noteRepository.loadByUserId(sl<FirebaseAuthImp>().userId()!);

      emit(LoadNote(notes, selections: selectedNoteId));
      return;
    }
    final notes = await noteRepository.load();
    emit(LoadNote(notes, selections: selectedNoteId));
  }

  void updateViewWithoutLoading() async {
    if (sl<FirebaseAuthImp>().userId() != null) {
      final notes =
          await noteRepository.loadByUserId(sl<FirebaseAuthImp>().userId()!);

      emit(LoadNote(notes, selections: selectedNoteId));
      return;
    }
    final notes = await noteRepository.load();
    emit(LoadNote(notes, selections: selectedNoteId));
  }

  Future<void> saveNote(Note note) async {
    if (sl<FirebaseAuthImp>().userId() != null) {
      note.userId = sl<FirebaseAuthImp>().userId();
    }
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
        selectedNoteId.clear();
        noteSelection = false;
        await loadNotes();
      }
    }
  }

  Future<void> searchNotes(String title) async {
    final searchedNotes = await noteRepository.search(title);
    if (searchedNotes.isNotEmpty) {
      emit(LoadNote(searchedNotes, selections: selectedNoteId));
    } else {}
  }

  Future<void> updateNote(Note note) async {
    final result = await noteRepository.update(note);
    emit(UpdateNote(result));
    if (result) {
      await loadNotes();
    }
  }

  bool proceedNavigation() {
    if (!noteSelection && selectedNoteId.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void onPressedNote(String noteId) {
    if (noteSelection) {
      if (selectedNoteId.contains(noteId)) {
        selectedNoteId.remove(noteId);
      } else {
        selectedNoteId.add(noteId);
      }
      updateViewWithoutLoading();
      if (selectedNoteId.isEmpty) {
        noteSelection = false;
      }
    }
  }

  void onLongPressedNote(String noteId) {
    if (!noteSelection || !selectedNoteId.contains(noteId)) {
      noteSelection = true;
      selectedNoteId.add(noteId);
      updateViewWithoutLoading();
    }
  }

  void clearSelections() {
    noteSelection = false;
    selectedNoteId.clear();
    updateViewWithoutLoading();
  }

  void shareNote() async {
    await noteRepository.shareNote(selectedNoteId[0]);
  }

  void resetTable() async {
    await noteRepository.resetTable();
  }
}
