part of 'notecubit_cubit.dart';

@immutable
abstract class NotecubitState extends Equatable {}

class NoteLoading extends NotecubitState {
  @override
  List<Object?> get props => [];
}

class Loading extends NotecubitState {
  @override
  List<Object?> get props => [];
}

class LoadNote extends NotecubitState {
  final List<Note> notes;
  final List<String> selections;
  LoadNote(this.notes, {required this.selections});

  @override
  List<Object?> get props => [notes];
}

class SaveNote extends NotecubitState {
  final bool success;
  SaveNote(this.success);

  @override
  List<Object?> get props => [success];
}

class UpdateNote extends NotecubitState {
  final bool updated;
  UpdateNote(this.updated);
  @override
  // TODO: implement props
  List<Object?> get props => [updated];
}

class DeleteNote extends NotecubitState {
  final bool deleted;
  DeleteNote(this.deleted);

  @override
  List<Object?> get props => [deleted];
}
