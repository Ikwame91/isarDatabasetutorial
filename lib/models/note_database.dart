import 'package:isar/isar.dart';
import 'package:isarbase_tutorial/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
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
    });
  }
}
