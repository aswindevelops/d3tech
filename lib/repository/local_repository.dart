import 'package:d3tech/models/item.dart';
import 'package:sqflite/sqflite.dart' as sql;

const kItemsTable = 'items';
const kD3TechDatabase = 'd3tech.db';

class LocalRepository {

  static Future<sql.Database> db() async {
    final db = await sql.openDatabase(kD3TechDatabase, version: 1,
        onCreate: (sql.Database db, int version) async {
      await _initTables(db);
    });
    return db;
  }

  static Future<void> _initTables(sql.Database db) async {
    await db.execute("""CREATE TABLE $kItemsTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    price REAL,
    image BLOB
    )""");
  }

  Future<int> insertItem(Item item) async {

    final db = await LocalRepository.db();
    final id = await db.insert(kItemsTable, item.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await LocalRepository.db();
    return db.query(kItemsTable, orderBy: 'id');
  }

  Future<int> updateItem(Item item) async {
    final db = await LocalRepository.db();
    final id = db.update(kItemsTable, item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
    return id;
  }

  Future<void> deleteItem(Item item) async {
    try {
      final db = await LocalRepository.db();
      db.delete(kItemsTable, where: 'id = ?', whereArgs: [item.id]);
    } catch (er) {
      print("Error while deleting");
    }
  }
}
