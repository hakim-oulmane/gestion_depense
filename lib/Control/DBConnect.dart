import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConnect {

  static Database _database;

  ///get db connection if exist otherwise create a new one
  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  ///init the database
  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "db_depense.db");

  // Check if the database exists
    var exists = await databaseExists(path);
//    exists = false; //for overwrite the old database

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from db_depense.db");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "db_depense.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
  // open the database
    Database db = await openDatabase(path);
    return db;
  }

  Future<void> closeDB() async{
    print("closing database");
    _database.close();
  }
}