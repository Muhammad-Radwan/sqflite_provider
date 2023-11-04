// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart' as fnd;
import 'package:sqflite_provider/helpers/db_helper.dart';
import 'package:sqflite_provider/models/category.dart';

class ExpenseModel extends fnd.ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get Categories => _categories;

  void getAllCategories() async {
    _categories = await DBHelper().getAllCategories();
    notifyListeners();
  }

  void addCategory(data) async {
    await DBHelper().addCategory(data);
    notifyListeners();
  }

  void deleteCategory(data) async {
    await DBHelper().deleteCategory(data);
    notifyListeners();
  }

  void updateCategory(data) async {
    await DBHelper().updateCategory(data);
    notifyListeners();
  }
}
