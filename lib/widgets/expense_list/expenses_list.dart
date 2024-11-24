import 'package:expense_tracker/provider/add_expense_provider.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesList extends ConsumerWidget{
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense, required this.mainScreenContext});

  final List<Expense> expenses;
  final void Function(Expense) removeExpense;
  final BuildContext mainScreenContext;

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Expense> expenses = ref.read(addExpenseProvider);
    return Container(
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          
          itemCount: expenses.length,
          itemBuilder: (cntx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              
            ),
            onDismissed: (direction) {
              //removeExpense(expenses[index]);
              
              ref.read(addExpenseProvider.notifier).removerExpense(expenses[index], context);
            },
            key: ValueKey(
              ExpenseItem(
                expenses[index],
              ),
            ),
            child: ExpenseItem(
              expenses[index],
            ),
          ),
        ),
      ),
    );
  }
}
