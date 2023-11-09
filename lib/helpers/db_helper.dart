// ignore_for_file: non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_provider/models/category.dart';
import 'package:sqflite_provider/models/expense.dart';

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

  Future<Category> getCategoryByID(int id) async {
    final dbConn = await getDBConn();
    List<Map<String, dynamic>> maps =
        await dbConn.query('categories', where: 'catID = ?', whereArgs: [id]);
    return Category.fromJson(maps[0]);
  }

  Future<List<Category>> getAllCategories() async {
    final dbConn = await getDBConn();
    List<Map<String, dynamic>> maps = await dbConn.query(
      'categories',
    );

    return List.generate(maps.length, (i) => Category.fromJson(maps[i]));
  }

  Future<int> addExpense(Expense exp) async {
    final dbConn = await getDBConn();
    return dbConn.insert('expenses', exp.toJson());
  }

  Future<int> updateExpense(Expense exp) async {
    final dbConn = await getDBConn();
    return dbConn
        .update('expenses', exp.toJson(), where: 'id = ?', whereArgs: [exp.id]);
  }

  Future<void> deleteExpense(Expense exp) async {
    final dbConn = await getDBConn();
    dbConn.delete('categories', where: 'id = ?', whereArgs: [exp.id]);
  }

  Future<List<Expense>> getAllExpenses() async {
    final dbConn = await getDBConn();
    List<Map<String, dynamic>> maps = await dbConn.query('table');

    return List.generate(maps.length, (i) => Expense.fromJson(maps[i]));
  }
}
