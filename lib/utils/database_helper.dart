// import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; //SQLite plugin for Flutter. Supports both iOS and Android.
import 'dart:async'; //for asyncronous call
import 'dart:io'; //File, socket, HTTP, and other I/O support for non-web applications
import 'package:path_provider/path_provider.dart'; //A Flutter plugin for finding commonly used locations on the filesystem. Supports iOS and Android.
import 'package:notekeeper/models/note.dart';

/*
  Whenever you access database, it will create a singleton instance 
  it will call initializedatabase() and open/create database then call the
  _createDb. this will complete method chaining


*/



class DatabaseHelper{
  //this instance will initialize only once in lifetime of application
  static DatabaseHelper _databaseHelper;   // singleton databasehelper 
  static Database _database; //Singleton database

  //database objects columns and names of database
  String noteTable = 'note_table';
  String colId='id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance(); //named constructor to cratei instance of databasehelper

  //factory constructor
  factory DatabaseHelper(){
    //initialize object
    //create the database helper instance only if it is null
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return  _databaseHelper; 
  }

  Future<Database> get database async {
    if (_database == null){
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initilizeDatabase() async{
    //get the directory path for both Android and iOS to store database.
    //getApplicationDocumentsDirectory() will pint to path direcotory package  
    // since it is waiting for future object we use await for async;
    Directory directory = await getApplicationDocumentsDirectory();

    // Define the path for our database
    String path = directory.path + 'notes.db';

    //Open/crate the database at given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    
    return notesDatabase;
  }

  //function that will help us create the database (MIgration)
  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
    '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  //Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async{
    Database db = await this.database;

    // the two lines below are same query with same output, the first is raw query
    
    //raw sql
    // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    
    //query using helper functions by passing parameters
    var result = await db.query(noteTable, orderBy: '$colPriority ASC')

    return result; 

  }
  //Insert Operation: Insert a Note object to database
    Future<int> insertNote(Note note) async{
      Database db = await this.database;
      var result =await db.insert(noteTable, note.toMap());
      return result;
    }

  //Update Operation: Update a Note object and save it to database
    Future<int> updateNote(Note note) async{
      var db = await this.database;
      var result = await db.update(noteTable, note.toMap(), where: '$colId=?', whereArgs: [note.id] );
      return result;
    }
  //delete Operation: Delete a Note object from database
    Future<int> deleteNote(int id) async {
      var db= await this.database;
      int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
      return result;
    }

  //Get number of Note objects in database
    Future<int> getCount() async {
      Database  db = await this.database;
      List<Map<String, dynamic>> x = await db.rawQuery('SELECT Count (*) from $noteTable');
      int result = Sqflite.firstIntValue(x);
      return result;
    }
}