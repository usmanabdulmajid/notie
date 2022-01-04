part of 'notecubit_cubit.dart';

@immutable
abstract class NotecubitState extends Equatable {}

class NotecubitInitial extends NotecubitState {
  @override
  List<Object?> get props => [];
}

class Loading extends NotecubitState {
  @override
  List<Object?> get props => [];
}

class LoadNote extends NotecubitState {
  final List<Note> notes;
  LoadNote(this.notes);

  @override
  List<Object?> get props => [notes];
}

class SaveNote extends NotecubitState {
  final bool success;
  SaveNote(this.success);

  @override
  List<Object?> get props => [success];
}

class DeleteNote extends NotecubitState {
  final bool deleted;
  DeleteNote(this.deleted);

  @override
  List<Object?> get props => [deleted];
}
