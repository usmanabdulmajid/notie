enum NoteType { text, audio }

extension ParseNoteType on NoteType {
  static NoteType fromString(String value) {
    NoteType noteType =
        NoteType.values.firstWhere((element) => element.name == value);
    return noteType;
  }
}
