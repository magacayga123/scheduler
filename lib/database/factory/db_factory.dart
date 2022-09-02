import 'dart:async';

import 'package:sqflite/sqflite.dart' as mysql;

class TDatabase {
  static late mysql.Database _db;
  static Future<void> createDatabase() async {
    String pathfirstpart = await mysql.getDatabasesPath();
    String actualpath = pathfirstpart + "/scheduler.db";
    _db = await mysql.openDatabase(actualpath, version: 1, onCreate: _createDb);
  }

  static FutureOr<void> _createDb(mysql.Database db, int version) {
    final String sql = '''create table scheduler(
      id TEXT  auto_increment,
      body TEXT,
      maximumNumber_frames INTEGER,
      startDate timestamp,
      endDate timestamp,
      isprivate TEXT,
      isRoutine TEXT,
    
      row TEXT,
      column TEXT,
      objective TEXT,
    )''';
    db.execute(sql);
  }

  static disposeDb() async {
    _db.isOpen ? await _db.close() : null;
  }

  static mysql.Database get getDatabase {
    return _db;
  }
}
