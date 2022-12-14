import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:students_productive_room/models/events_model/events.dart';
import '../models/notes_model/notes.dart';

class YouDatabase {
  static final YouDatabase instance = YouDatabase._init();
  static Database? _database;
  YouDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB('You.db');
    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database database, int version) async {
    NotesFields notesFields = NotesFields();
    EventsFields eventsFields = EventsFields();

    await database.execute("CREATE TABLE ${notesFields.notesTableName}"
        "(${notesFields.notesId} TEXT PRIMARY KEY , "
        "${notesFields.notesTitle} TEXT NOT NULL,"
        "${notesFields.notesNote} TEXT NOT NULL,"
        "${notesFields.notesNoteColor} TEXT NOT NULL,"
        "${notesFields.notesNoteFont} TEXT NOT NULL,"
        "${notesFields.notesCreatedOn} TEXT NOT NULL )",);

    await database.execute("CREATE TABLE ${eventsFields.eventTableName}"
        "(${eventsFields.eventId} TEXT PRIMARY KEY , "
        "${eventsFields.eventTitle} TEXT NOT NULL,"
        "${eventsFields.eventLocation} TEXT NOT NULL,"
        "${eventsFields.eventStartTime} TEXT NOT NULL,"
        "${eventsFields.eventColor} TEXT NOT NULL,"
        "${eventsFields.eventEndTime} TEXT NOT NULL )",);

  }


  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }
}
