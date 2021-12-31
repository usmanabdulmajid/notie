import 'package:notie/domain/models/note.dart';

abstract class ILoadNote {
  Future<List<Note>> load();
}
