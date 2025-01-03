import 'dart:developer';

import 'package:notes_app_exam_tk2/model/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabaseService {
  late String path;

  NotesDatabaseService._();

  static final NotesDatabaseService db = NotesDatabaseService._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await init();
    return _database;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'notes.db');
    log("Entered path $path");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Notes (_id INTEGER PRIMARY KEY, title TEXT, content TEXT, date TEXT, isImportant INTEGER);');
      log('New table created at $path');
    });
  }

  Future<List<NotesModel>> getNotesFromDB() async {
    final db = await database;
    List<NotesModel> notesList = [];
    List<Map<String, dynamic>> maps = await db!.query('Notes',
        columns: ['_id', 'title', 'content', 'date', 'isImportant']);
    if (maps.isNotEmpty) {
      for (var map in maps) {
        notesList.add(NotesModel.fromMap(map));
      }
    }
    return notesList;
  }

  updateNoteInDB(NotesModel updatedNote) async {
    final db = await database;
    await db!.update('Notes', updatedNote.toMap(),
        where: '_id = ?', whereArgs: [updatedNote.id]);
    log('Note updated: ${updatedNote.title} ${updatedNote.content}');
  }

  deleteNoteInDB(NotesModel noteToDelete) async {
    final db = await database;
    await db!.delete('Notes', where: '_id = ?', whereArgs: [noteToDelete.id]);
    log('Note deleted');
  }

  Future<NotesModel> addNoteInDB(NotesModel newNote) async {
    final db = await database;
    if (newNote.title!.trim().isEmpty) newNote.title = 'Untitled Note';
    int id = await db!.transaction((transaction) async {
      return await transaction.rawInsert(
          'INSERT into Notes(title, content, date, isImportant) VALUES ("${newNote.title}", "${newNote.content}", "${newNote.date!.toIso8601String()}", ${newNote.isImportant == true ? 1 : 0});');
    });

    newNote.id = id;
    log('Note added: ${newNote.title} ${newNote.content}');
    return newNote;
  }
}
