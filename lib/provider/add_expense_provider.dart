import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:expense_tracker/widgets/expenses.dart';

class AddExpenseNotifier extends StateNotifier <List<Expense>>{
  AddExpenseNotifier(this.ref) : super([
    Expense(
      title: "Flutter course",
      amount: 449.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Library Fees",
      amount: 300,
      date: DateTime.now(),
      category: Category.work,
    )
  ]);

  final StateNotifierProviderRef ref;

  void addExpense(Expense expense){
    state = [...state,expense];
  }
  void removerExpense(Expense expense, BuildContext context){
    //print(state);

    final index = state.indexOf(expense);
    //print("Index in add method ${index}");
    
    state = [...state]..remove(expense);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            
            state = [...state]..insert(index, expense);
          },
        ),
      ),
    );
  }
}

final addExpenseProvider = StateNotifierProvider<AddExpenseNotifier, List<Expense>>((ref){

  return AddExpenseNotifier(ref);
});

