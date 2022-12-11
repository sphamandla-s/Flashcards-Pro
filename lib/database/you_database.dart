import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/notes.dart';

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

    await database.execute("CREATE TABLE ${notesFields.notesTableName}"
        "(${notesFields.notesId} TEXT PRIMARY KEY , "
        "${notesFields.notesTitle} TEXT NOT NULL,"
        "${notesFields.notesNote} TEXT NOT NULL,"
        "${notesFields.notesNoteColor} BOOLEAN NOT NULL,"
        "${notesFields.notesCreatedOn} TEXT NOT NULL )",);
  }

  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }
}
