import 'package:flutter/material.dart';

import '../repository/notes_respository.dart';

class NotesViewModel extends ChangeNotifier {
  final NotesRepository _notesRepository = NotesRepository();

  Future<List<Map<String, Object?>>> get getAllAllNotes =>
      _notesRepository.retrieveAllNotes();

  addNote(String id, String tittle, String note, DateTime createdOn,
      String noteColor) async {
    await _notesRepository.createNote(id, tittle, note, createdOn, noteColor);
    notifyListeners();
  }

  deleteNote(String id) {
    _notesRepository.deleteNote(id);
    notifyListeners();
  }

  updateNote(String id, String tittle, String note, DateTime createdOn,
      String noteColor) async {
    await _notesRepository.updateNote(id, tittle, note, createdOn, noteColor);
  }

  closeDatabase() {
    _notesRepository.closeDB();
    notifyListeners();
  }
}
