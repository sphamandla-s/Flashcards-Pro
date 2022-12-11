

class NotesFields{
  final String _noteTableName = 'notes';
  final String _id = '_id';
  final String _title = 'title';
  final String _note = 'note';
  final String _createdOn = 'createdOn';
  final String _noteColor = 'noteColor';

  String get notesTableName => _noteTableName;
  String get notesId  => _id ;
  String get notesTitle => _title;
  String get notesNote => _note;
  String get notesCreatedOn => _createdOn;
  String get notesNoteColor => _noteColor;

}


class Notes {

  final String id;
  final String title;
  final String note;
  final DateTime createdOn;
  final String noteColor;

  Notes(
      {required this.id,
      required this.title,
      required this.note,
      required this.createdOn,
      required this.noteColor});

  Notes.fromJson(Map<String, Object?> jsonMap)
      : this(
    id : jsonMap['_id'] as String,
    createdOn:
    DateTime.parse(jsonMap['createdOn'] as String),
    title: jsonMap['title'] as String,
    note: jsonMap['note'] as String,
    noteColor: jsonMap['noteColor'] as String,
  );

  Map<String, Object?> toJson() {
    return {
      '_id' : id,
      'title': title,
      'createdOn': createdOn.toIso8601String(),
      'note': note,
      'noteColor': noteColor,
    };
  }
}
