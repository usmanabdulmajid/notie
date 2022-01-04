import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notie/domain/models/note.dart';
import 'package:notie/infrastructure/repositories/inote_repository.dart';

part 'notecubit_state.dart';

class NotecubitCubit extends Cubit<NotecubitState> {
  final INoteRepository noteRepository;

  NotecubitCubit(this.noteRepository) : super(NotecubitInitial());

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

  Future<void> deleteNote(List<String> ids) async {
    final result = await noteRepository.delete(ids);
    if (result) {
      await loadNotes();
    }
  }

  Future<void> searchNotes(String title) async {
    final searchedNotes = await noteRepository.search(title);
    emit(LoadNote(searchedNotes));
  }

  Future<void> updateNote(Note note) async {
    final result = await noteRepository.update(note);
    if (result) {
      await loadNotes();
    }
  }
}
