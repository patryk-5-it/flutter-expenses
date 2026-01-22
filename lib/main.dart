import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(150, 125, 70, 221));

void main() {
  runApp(
    const MaterialApp(
      home: Expenses()
    ),
    
  );
}