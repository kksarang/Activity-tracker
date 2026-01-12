import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('activity.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE users (
        id $idType,
        email $textType,
        name $textType,
        photoUrl TEXT,
        lastSyncedAt $integerType
      )
    ''');

    await db.execute('''
      CREATE TABLE activities (
        id $idType,
        userId $textType,
        title $textType,
        description TEXT,
        type $textType,
        startTime $integerType,
        endTime $integerType,
        isSynced $boolType
      )
    ''');
  }

  // Example CRUD operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String id) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      columns: ['id', 'email', 'name', 'photoUrl'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
