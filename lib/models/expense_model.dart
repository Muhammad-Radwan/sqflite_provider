// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart' as fnd;
import 'package:sqflite_provider/helpers/db_helper.dart';
import 'package:sqflite_provider/models/category.dart';
import 'package:sqflite_provider/models/expense.dart';

class ExpenseModel extends fnd.ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get Categories => _categories;

  List<Expense> _expenses = [];
  List<Expense> get Expenses => _expenses;

  //double _expensesTotal = 0.0;
  double get ExppensesTotal => getTotalExpenses();

  double getTotalExpenses() {
    double initial = 0;
    for (int i = 0; i <= _expenses.length; i++) {
      initial += _expenses[i].expenseValue!;
    }
    return initial;
  }

  void getAllCategories() async {
    _categories = await DBHelper().getAllCategories();
    notifyListeners();
  }

  void addCategory(Category data) async {
    await DBHelper().addCategory(data);
    notifyListeners();
  }

  void deleteCategory(Category data) async {
    await DBHelper().deleteCategory(data);
    notifyListeners();
  }

  void updateCategory(Category data) async {
    await DBHelper().updateCategory(data);
    notifyListeners();
  }

  void getAllExpenss() async {
    _expenses = await DBHelper().getAllExpenses();
    notifyListeners();
  }

  void addExpense(Expense data) async {
    await DBHelper().addExpense(data);
    notifyListeners();
  }

  void updateExpsne(Expense data) async {
    await DBHelper().updateExpense(data);
    notifyListeners();
  }

  void deleteExpsne(Expense data) async {
    await DBHelper().deleteExpense(data);
    notifyListeners();
  }
}
