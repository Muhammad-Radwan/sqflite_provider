import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_provider/models/expense_model.dart';
import 'package:sqflite_provider/pages/add_expense.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddExpense()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Consumer<ExpenseModel>(builder: (context, model, child) {
              model.getAllExpenses();
              return Expanded(
                  child: ListView.builder(
                      itemCount: model.Expenses.length,
                      itemBuilder: (context, i) {
                        return Card(
                          shadowColor: Colors.brown,
                          elevation: 2.5,
                          child: ListTile(
                            leading: Text(
                              '${model.Expenses[i].expenseValue}',
                              style: TextStyle(fontSize: 20),
                            ),
                            title: Text('${model.Expenses[i].notes}'),
                            subtitle: Text('${model.Expenses[i].expenseDate}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                model.deleteExpense(model.Expenses[i]);
                              },
                            ),
                          ),
                        );
                      }));
            }),
            Consumer<ExpenseModel>(builder: (context, model, child) {
              model.sumExpenses();
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Text(
                  'Total Expenses: ${model.TotalExpenses}',
                  style: TextStyle(fontSize: 20),
                ),
              );
            })
          ]),
        ),
      ),
    );
  }
}
