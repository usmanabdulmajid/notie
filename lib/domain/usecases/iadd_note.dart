import 'package:notie/domain/models/note.dart';

abstract class IAddNote {
  Future<bool> add(Note note);
}
