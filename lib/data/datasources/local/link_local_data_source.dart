import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../domain/models/LinkData.dart';

class LinkLocalDataSource {
  Database? _database;
  String tableName = 'links';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'link_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE links (id INTEGER PRIMARY KEY AUTOINCREMENT, link TEXT)');
  }

  Future<List<LinkData>> getAllLinks() async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return LinkData(
        id: maps[i]['id'],
        link: maps[i]['link'],
      );
    });
  }

  Future<void> addLink(LinkData link) async {
    final db = await database;
    await db.insert(
      tableName,
      link.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}