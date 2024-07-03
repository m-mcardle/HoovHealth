import 'package:sqflite/sqflite.dart';

class MigrationV2 {
  void up(Database db) async {
    await db.execute('''
      CREATE TABLE SystemScan (
        id INTEGER PRIMARY KEY,
        minor INT,
        major INT,
        build INT,
        processor_type TEXT,
        arch TEXT,
        hostname TEXT,
        platform_like TEXT,
        platform TEXT,
        name TEXT,
        physical_memory INT,
        version REAL,
        uptime REAL,
        timestamp INTEGER
      )
    ''');
  }

  void down(Database db) async {
    await db.execute('''
      DROP TABLE SystemScan
    ''');
  }
}