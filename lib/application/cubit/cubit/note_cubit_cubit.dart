import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'note_cubit_state.dart';

class NoteCubitCubit extends Cubit<NoteCubitState> {
  NoteCubitCubit() : super(NoteCubitInitial());
}
