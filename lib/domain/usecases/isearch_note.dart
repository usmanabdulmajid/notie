import 'package:notie/domain/models/note.dart';

abstract class ISearchNote {
  Future<List<Note>> search(String title);
}
