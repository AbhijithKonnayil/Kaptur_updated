import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static final SQLHelper instance = SQLHelper._();
  static Database? _database;

  SQLHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'projects_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE projects(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
        );
      },
    );
  }

  Future<void> saveProjectName(String projectName) async {
    final db = await instance.database;
    await db.insert(
      'projects',
      {'name': projectName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
