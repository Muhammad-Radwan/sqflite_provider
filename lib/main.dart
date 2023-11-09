// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_provider/models/expense_model.dart';
import 'package:sqflite_provider/pages/add_category.dart';
import 'package:sqflite_provider/pages/add_expense.dart';
import 'package:sqflite_provider/pages/categories_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ExpenseModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorSchemeSeed: Colors.brown,
              textTheme: GoogleFonts.mavenProTextTheme()),
          home: AddExpense(),
        ));
  }
}
