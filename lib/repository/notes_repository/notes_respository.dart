import 'package:students_productive_room/database/you_database.dart';
import '../../models/notes_model/notes.dart';

class NotesRepository {
  createNote(String id, String tittle, String note, DateTime createdOn,
      String noteColor, String noteFont) async {
    final db = await YouDatabase.instance.database;
    await db.insert(
        'notes',
        Notes(
          id: id,
          title: tittle,
          note: note,
          createdOn: createdOn,
          noteColor: noteColor,
          noteFont: noteFont,
        ).toJson());
  }

  Future<List<Map<String, Object?>>> retrieveAllNotes() async {
    final db = await YouDatabase.instance.database;
    final queryResult = await db.query('notes', orderBy: 'createdOn DESC');
    return queryResult;
  }

  Future<Notes> readSingleNote(String id) async {
    final db = await YouDatabase.instance.database;
    final note = await db.query('notes', where: '_id = ?', whereArgs: [id]);
    return Notes.fromJson(note[0]);
  }

  Future<void> deleteNote(String id) async {
    final db = await YouDatabase.instance.database;
    await db.delete(
      'notes',
      where: "_id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateNote(String id, String tittle, String note,
      DateTime createdOn, String noteColor, String noteFont) async {
    Notes notes = Notes(
      id: id,
      title: tittle,
      note: note,
      createdOn: createdOn,
      noteColor: noteColor,
      noteFont: noteFont,
    );
    final db = await YouDatabase.instance.database;
    await db.update('notes', notes.toJson(),
        where: "_id = ?", whereArgs: [notes.id]);
  }

  closeDB() async {
    final db = await YouDatabase.instance.database;
    db.close();
  }
}
