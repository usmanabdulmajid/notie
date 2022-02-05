import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<String> selectedNoteId = [];
  Map<int, bool?> selectionMap = <int, bool?>{};

  Future<void> loadNotes() async {
    final notes = await noteRepository.load();
    emit(LoadNote(notes, selections: selectedNoteId));
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
      loadNotes();
      if (selectedNoteId.isEmpty) {
        noteSelection = false;
      }
    }
  }

  void onLongPressedNote(String noteId) {
    if (!noteSelection || !selectedNoteId.contains(noteId)) {
      noteSelection = true;
      selectedNoteId.add(noteId);
      loadNotes();
    }
  }

  void clearSelections() {
    noteSelection = false;
    selectedNoteId.clear();
    loadNotes();
  }

  void shareNote() async {
    await noteRepository.shareNote(selectedNoteId[0]);
  }
}
