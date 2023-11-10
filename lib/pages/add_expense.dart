import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_provider/models/category.dart';
import 'package:sqflite_provider/models/expense.dart';
import 'package:sqflite_provider/models/expense_model.dart';
import 'package:sqflite_provider/pages/expenses_list.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  Category? selectedCategory = Category();
  TextEditingController dateController = TextEditingController();
  TextEditingController expenseValueController = TextEditingController();
  TextEditingController expenseNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Expense')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Consumer<ExpenseModel>(builder: (context, model, child) {
            model.getAllCategories();
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<Category>(
                  isExpanded: true,
                  hint: const Text('Please Choose a Category'),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  items: model.Categories.map((e) {
                    return DropdownMenuItem(
                        value: e, child: Text('${e.catName}'));
                  }).toList(),
                ),
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          TextField(
            readOnly: true,
            controller: dateController,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Expense Date',
                prefixIcon: Icon(Icons.calendar_today)),
            onTap: () => showDate(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: expenseValueController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Expense Value',
                  prefixIcon: const Icon(Icons.money))),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: expenseNoteController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Expense Notes',
                  prefixIcon: const Icon(Icons.note))),
          const SizedBox(
            height: 10,
          ),
          Consumer<ExpenseModel>(
            builder: (context, model, child) {
              return ElevatedButton(
                onPressed: () async {
                  Expense exp = Expense(
                      catID: selectedCategory!.catID,
                      expenseDate: dateController.text,
                      expenseValue: expenseValueController.text,
                      notes: expenseNoteController.text);
                  model.addExpense(exp);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExpensesList()));
                },
                child: const Text(
                  'Save Expense',
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          )
        ]),
      )),
    );
  }

  Future<void> showDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    setState(() {
      dateController.text = pickedDate.toString();
    });
  }
}
