// ignore_for_file: non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_provider/models/category.dart';

class DBHelper {
  String db_name = 'mopense.db';

  Future<Database> getDBConn() async {
    return openDatabase(join(await getDatabasesPath(), db_name), version: 3,
        onCreate: (db, version) {
      db.execute("""
        CREATE TABLE categories(
        catID INTEGER PRIMARY KEY AUTOINCREMENT,
        catName TEXT NOT NULL)
        """);

      db.execute("""
        CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        catID int NOT NULL,
        expenseDate TEXT NOT NULL,
        expenseValue TEXT NOT NULL,
        notes TEXT NOT NULL,
        FOREIGN KEY("catID") REFERENCES "categories"("catID"))
        """);
    });
  }

  Future<int> addCategory(Category cat) async {
    final dbConn = await getDBConn();
    return dbConn.insert('categories', cat.toJson());
  }

  Future<int> updateCategory(Category cat) async {
    final dbConn = await getDBConn();
    return dbConn.update('categories', cat.toJson(),
        where: 'catID = ?', whereArgs: [cat.catID]);
  }

  Future<void> deleteCategory(Category cat) async {
    final dbConn = await getDBConn();
    dbConn.delete('categories', where: 'catID = ?', whereArgs: [cat.catID]);
  }

  Future<List<Category>> getAllCategories() async {
    final dbConn = await getDBConn();
    List<Map<String, dynamic>> maps = await dbConn.query('categories');

    return List.generate(maps.length, (i) => Category.fromJson(maps[i]));
  }
}
