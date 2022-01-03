import 'package:notie/domain/models/note.dart';
import 'package:notie/domain/usecases/isearch_note.dart';

class SearchNote implements ISearchNote {
  @override
  Future<List<Note>> search(String title) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
