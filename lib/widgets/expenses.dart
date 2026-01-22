import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpansesState();
  }
}

class _ExpansesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter course',
      amount: 40,
      date: DateTime.now(),
      category: Category.work,
    ),

    Expense(
      title: 'Test',
      amount: 20,
      date: DateTime.now(),
      category: Category.leisure,
    ),

    Expense(
      title: 'Test 2',
      amount: 30,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(onAddExpense: _addExpense);
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wydatek został usunięty'),
        duration: Duration(seconds: 10),
        action: SnackBarAction(label: 'Cofnij', onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
          
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(child: Text('Brak wydatków'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Wydatki', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
