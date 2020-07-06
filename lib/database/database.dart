import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final contactTABLE = 'Contact';

class DataBaseProvider {
  static final DataBaseProvider dbProvider = DataBaseProvider();
  Database _database;

  Future<Database> get getDatabase async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ContactTest.db");

    var database = await openDatabase(path, version: 1, onCreate: initDB);
    return database;
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $contactTABLE ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT,"
        "mobileNo TEXT,"
        "landlineNo TEXT,"
        "image TEXT,"
        "isFav INTEGER "
        ")");
  }
}
