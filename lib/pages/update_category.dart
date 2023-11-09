// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_provider/models/category.dart';
import 'package:sqflite_provider/models/expense_model.dart';

class UpdateCategory extends StatefulWidget {
  Category? category;
  UpdateCategory({super.key, required this.category});

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  TextEditingController _catController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              '${widget.category!.catName}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _catController,
              decoration: InputDecoration(
                  hintText: 'enter new value',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 10),
            Consumer<ExpenseModel>(builder: (context, model, child) {
              return Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        Category upCat = Category(
                            catID: widget.category!.catID,
                            catName: _catController.text);
                        model.updateCategory(upCat);
                        Navigator.of(context).pop();
                      },
                      child: Text('Save Changes',
                          style: TextStyle(fontSize: 18))));
            })
          ]),
        ),
      ),
    );
  }
}
