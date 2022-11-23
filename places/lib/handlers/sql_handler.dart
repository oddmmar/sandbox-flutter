import 'package:places/handlers/db_interface.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlHandler implements DbHandler {
  SqlHandler() {
    _dbInstance = _openDb();
  }
  late Future<Database> _dbInstance;

  Future<Database> _openDb() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  @override
  Future<void> insert(
      {required String table, required Map<String, Object> data}) async {
    final db = await _dbInstance;
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getData({required String table}) async {
    final db = await _dbInstance;
    return db.query(table);
  }
}
