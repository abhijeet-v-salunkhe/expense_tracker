//import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expenses.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/provider/add_expense_provider.dart';

class Expenses extends ConsumerStatefulWidget {
  const Expenses({super.key});

  @override
  ConsumerState<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends ConsumerState<Expenses> {
  // final List<Expense> _registeredExpenses = [
  //   Expense(
  //     title: "Flutter course",
  //     amount: 449.0,
  //     date: DateTime.now(),
  //     category: Category.work,
  //   ),
  //   Expense(
  //     title: "Library Fees",
  //     amount: 300,
  //     date: DateTime.now(),
  //     category: Category.work,
  //   )
  // ];
  List<Expense>_registeredExpenses =[];
  @override
  void initState() {
    super.initState();
    _registeredExpenses = ref.read(addExpenseProvider);
  }

  void _onClickadd() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cntx) => NewExpenses(addnewExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _registeredExpenses = ref.watch(addExpenseProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget mainContent = const Center(
      child: Text("No Expenses are present, add the expense if have!"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, removeExpense: _removeExpense, mainScreenContext: context,);
    }
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _onClickadd,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: height > width
          ? Column(
              children: [
                chart(expeneses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: chart(
                    expeneses: _registeredExpenses,
                  ),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
