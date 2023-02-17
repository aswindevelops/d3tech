import 'package:d3tech/models/item.dart';
import 'package:sqflite/sqflite.dart' as sql;

const kItemsTable = 'items';
const kD3TechDatabase = 'd3tech.db';

class LocalRepository {
  /// creating database if does not exist, then or if exists the method will
  /// return an object of the database class
  static Future<sql.Database> db() async {
    final db = await sql.openDatabase(kD3TechDatabase, version: 1,
        onCreate: (sql.Database db, int version) async {
      await _initTables(db);
    });
    return db;
  }

  /// creating tables if they does not exist
  static Future<void> _initTables(sql.Database db) async {
    await db.execute("""CREATE TABLE $kItemsTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    price REAL,
    image BLOB
    )""");
  }

  /// inserting item to local databnse,
  Future<int> insertItem(Item item) async {
    final db = await LocalRepository.db();
    final id = await db.insert(kItemsTable, item.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  /// returns a list of maps from items table
  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await LocalRepository.db();
    return db.query(kItemsTable, orderBy: 'id');
  }

  /// updates an item in items table, for a given id
  Future<int> updateItem(Item item) async {
    final db = await LocalRepository.db();
    final id = db.update(kItemsTable, item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
    return id;
  }

  /// delete an item from the items table
  Future<void> deleteItem(Item item) async {
    try {
      final db = await LocalRepository.db();
      db.delete(kItemsTable, where: 'id = ?', whereArgs: [item.id]);
    } catch (er) {
      print("Error while deleting");
    }
  }
}
