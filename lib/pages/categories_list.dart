// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_provider/models/expense_model.dart';
import 'package:sqflite_provider/pages/add_category.dart';
import 'package:sqflite_provider/pages/update_category.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddCategory()));
          }),
      appBar: AppBar(title: Text('Categories')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Consumer<ExpenseModel>(builder: (context, model, child) {
              model.getAllCategories();
              return Expanded(
                child: ListView.builder(
                    itemCount: model.Categories.length,
                    itemBuilder: (context, i) {
                      return Card(
                        shadowColor: Colors.brown,
                        elevation: 3,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateCategory(
                                      category: model.Categories[i],
                                    )));
                          },
                          title: Text('${model.Categories[i].catName}'),
                          trailing: ElevatedButton(
                            child: Icon(Icons.remove),
                            onPressed: () {
                              model.deleteCategory(model.Categories[i]);
                            },
                          ),
                        ),
                      );
                    }),
              );
            })
          ],
        ),
      )),
    );
  }
}
