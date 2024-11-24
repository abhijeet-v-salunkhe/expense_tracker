import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/provider/add_expense_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveExpenseNotifier extends StateNotifier<List<Expense>> {
  RemoveExpenseNotifier(this.ref,this.registeredExpenses) : super(registeredExpenses);
  final StateNotifierProviderRef ref;
  final List<Expense> registeredExpenses;

  void removeExpense(Expense expense){
    
  }

}

final removeExpenseProvider = StateNotifierProvider<RemoveExpenseNotifier, List<Expense>>((ref){
  final registeredExpenses = ref.read(addExpenseProvider);
  return RemoveExpenseNotifier(ref,registeredExpenses);
});