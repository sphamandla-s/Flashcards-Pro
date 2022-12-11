import 'package:flutter/material.dart';

import '../repository/notes_respository.dart';

class NotesViewModel extends ChangeNotifier {
  NotesRepository notesRepository = NotesRepository();

  Future<List<Map<String, Object?>>> get getAllAllNotes =>
      notesRepository.retrieveAllNotes();

  addNote(String id, String tittle, String note, DateTime createdOn,
  String noteColor) async {
    await notesRepository.createNote(id, tittle,note,createdOn,noteColor);
  }


  closeDatabase(){
    notesRepository.closeDB();
  }
}
