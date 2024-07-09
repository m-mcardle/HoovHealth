import 'package:sqflite/sqflite.dart';
import 'migrations/v2.dart';

class DatabaseHelper {
  static Database? _db;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    // Lazily instantiate the db the first time it is accessed.
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase('hoov_health.db', version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Run migration according to the oldVersion and newVersion
    if (oldVersion == 1 && newVersion == 2) {
      MigrationV2().up(db);
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE NetworkScan (
        id INTEGER PRIMARY KEY,
        channel_band INT,
        channel_width INT,
        channel INT,
        security TEXT,
        transmit_rate REAL,
        noise_level INT,
        rssi INT,
        timestamp INTEGER
      )
    ''');

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

  Future insertNetworkScan({
    required int channel_band,
    required int channel_width,
    required int channel,
    required String security,
    required double transmit_rate,
    required int noise_level,
    required int rssi,
  }) async {
    final db = await database;
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000; // Unix timestamp in seconds
    await db.transaction((txn) async {
      int id = await txn.rawInsert(
        'INSERT INTO NetworkScan(channel_band, channel_width, channel, security, transmit_rate, noise_level, rssi, timestamp) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
        [channel_band, channel_width, channel, security, transmit_rate, noise_level, rssi, currentTimestamp],
      );
      print('inserted: $id');
    });
  }

  Future<Map<String, dynamic>> getLatestNetworkScan(String query) async {
    final db = await database;
    // check if a record exists
    if ((await db.rawQuery('SELECT COUNT(*) FROM NetworkScan'))[0]['COUNT(*)'] == 0) {
      return {};
    }
    return (await db.rawQuery('$query ORDER BY timestamp DESC LIMIT 1'))[0];
  }

  Future insertSystemScan({
    required int minor,
    required int major,
    required int build,
    required String processor_type,
    required String arch,
    required String hostname,
    required String platform_like,
    required String platform,
    required String name,
    required int physical_memory,
    required double version,
    required double uptime,
  }) async {
    final db = await database;
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000; // Unix timestamp in seconds
    await db.transaction((txn) async {
      int id = await txn.rawInsert(
        'INSERT INTO SystemScan(minor, major, build, processor_type, arch, hostname, platform_like, platform, name, physical_memory, version, uptime, timestamp) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [minor, major, build, processor_type, arch, hostname, platform_like, platform, name, physical_memory, version, uptime, currentTimestamp],
      );
      print('inserted: $id');
    });
  }

  Future<Map<String, dynamic>> getLatestSystemScan() async {
    final db = await database;
    // check if a record exists
    if ((await db.rawQuery('SELECT COUNT(*) FROM SystemScan'))[0]['COUNT(*)'] == 0) {
      return {};
    }

    return (await db.rawQuery('SELECT * FROM SystemScan ORDER BY timestamp DESC LIMIT 1'))[0];
  }
}
