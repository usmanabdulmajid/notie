import 'package:notie/domain/models/note.dart';

abstract class IUpdateNote {
  Future<bool> update(Note note);
}
