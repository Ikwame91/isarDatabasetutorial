import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isarbase_tutorial/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize Isar and open the database.
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //List of notes
  final List<Note> currentNotes = [];

//Create a new note and save to DB
  Future<void> addNewNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;
    //SAVE TO DB
    await isar.writeTxn(() async {
      isar.notes.put(newNote);
      await fetchNotes();
    });
    //reread from db
  }

  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }

  //Update notes in DB
  Future<void> updateNote(int id, String newText) async {
    final existinNote = await isar.notes.get(id);
    if (existinNote != null) {
      existinNote.text = newText;
      await isar.writeTxn(() async {
        await isar.notes.put(existinNote);
        await fetchNotes();
      });
    }
  }

  //Delete notes from DB
  Future<void> deleteNotes(int id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
      await fetchNotes();
    });
  }
}
