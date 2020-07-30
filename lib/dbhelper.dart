import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import './models/classes/notes.dart';

// the database helper class
class Databasehelper {
  // database name
  static final _databasename = "todo.db";
  static final _databaseversion = 2;

  // the table name
  static final table = "mytable";
  static final table1 = "mytable1";
  static final table2 = "mytable2";
  static final table3 = "mytable3";
  static final table4 = "mytable4";

  // column names
  static final columnID = 'id';
  String colTitle = 'title';
  String colDate = 'date';

  // a database
  static Database _database;
  static Databasehelper _databaseHelper;

  Databasehelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory Databasehelper() {
    if (_databaseHelper == null) {
      _databaseHelper = Databasehelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  // function to return a database
  Future<Database> initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    var notesDatabase = await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
    return notesDatabase;
  }

  // create a database since it doesn't exist
  Future _onCreate(Database db, int version) async {
    // sql code
    await db.execute('''
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY,
        $colTitle TEXT,
			  $colDate TEXT
      );
      ''');
    await db.execute('''
      CREATE TABLE $table1 (
        $columnID INTEGER PRIMARY KEY,
        $colTitle TEXT,
			  $colDate TEXT
      );
      ''');
    await db.execute('''
      CREATE TABLE $table2 (
        $columnID INTEGER PRIMARY KEY,
        $colTitle TEXT,
			  $colDate TEXT
      );
      ''');
    await db.execute('''
      CREATE TABLE $table3 (
        $columnID INTEGER PRIMARY KEY,
        $colTitle TEXT,
			  $colDate TEXT
      );
      ''');
    await db.execute('''
      CREATE TABLE $table4 (
        $columnID INTEGER PRIMARY KEY,
        $colTitle TEXT,
			  $colDate TEXT
      );
      ''');
  }

  // functions to insert data
  Future<int> insert(tableName, Note note) async {
    Database db = await this.database;
    return await db.insert(tableName, note.toMap());
  }

  // function to query all the rows
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await this.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryall1() async {
    Database db = await this.database;
    return await db.query(table1);
  }

  Future<List<Map<String, dynamic>>> queryall2() async {
    Database db = await this.database;
    return await db.query(table2);
  }

  Future<List<Map<String, dynamic>>> queryall3() async {
    Database db = await this.database;
    return await db.query(table3);
  }

  Future<List<Map<String, dynamic>>> queryall4() async {
    Database db = await this.database;
    return await db.query(table4);
  }

  // function to delete some data
  Future<int> deletedata(tableName, int id) async {
    Database db = await this.database;
    var res = await db.delete(tableName, where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> update(tableName, Note note) async {
    Database db = await this.database;
    var res = await db
        .update(tableName, note.toMap(), where: "id = ?", whereArgs: [note.id]);
    return res;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount1() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table1');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount2() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table2');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount3() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table3');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount4() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table4');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {
    var noteMapList = await queryall(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

  Future<List<Note>> getNoteList1() async {
    var noteMapList = await queryall1(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

  Future<List<Note>> getNoteList2() async {
    var noteMapList = await queryall2(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

  Future<List<Note>> getNoteList3() async {
    var noteMapList = await queryall3(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

  Future<List<Note>> getNoteList4() async {
    var noteMapList = await queryall4(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}
