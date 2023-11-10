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

  double _totalExpenses = 0.0;
  double get TotalExpenses => _totalExpenses;

  void sumExpenses() {
    double rv = 0.0;
    for (int i = 0; i < _expenses.length; i++) {
      rv += double.parse('${_expenses[i].expenseValue}');
    }
    _totalExpenses = rv;
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

  void getAllExpenses() async {
    _expenses = await DBHelper().getAllExpenses();
    notifyListeners();
  }

  void addExpense(Expense data) async {
    await DBHelper().addExpense(data);
    notifyListeners();
  }

  void updateExpense(Expense data) async {
    await DBHelper().updateExpense(data);
    notifyListeners();
  }

  void deleteExpense(Expense data) async {
    await DBHelper().deleteExpense(data);
    notifyListeners();
  }

  Future<String> getExpenseNameByID(int? id) async {
    return await DBHelper().getCategoryNameByID(id!);
  }
}
