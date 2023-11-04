// ignore_for_file: prefer_const_constructors, prefer_final_fields, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_provider/models/category.dart';
import 'package:sqflite_provider/models/expense_model.dart';
import 'package:sqflite_provider/pages/categories_list.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _catNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
        actions: [
          Consumer<ExpenseModel>(builder: (context, model, child) {
            model.getAllCategories();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Count: ${model.Categories.length}'),
            );
          })
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: _catNameController,
              decoration: InputDecoration(
                  hintText: 'Category Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                child: Consumer<ExpenseModel>(builder: (context, model, child) {
                  return ElevatedButton(
                    onPressed: () {
                      Category cat = Category(catName: _catNameController.text);
                      model.addCategory(cat);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoriesList()));
                    },
                    child: Text(
                      'Add Category',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }))
          ]),
        ),
      ),
    );
  }
}
