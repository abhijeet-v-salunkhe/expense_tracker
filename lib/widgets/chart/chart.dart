import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:expense_tracker/provider/add_expense_provider.dart';

class chart extends ConsumerWidget {
  const chart({super.key, required this.expeneses});

  final List<Expense> expeneses;

  
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.ofCategory(allExpenses: expeneses, category: Category.food),
      ExpenseBucket.ofCategory(
          allExpenses: expeneses, category: Category.leisure),
      ExpenseBucket.ofCategory(
          allExpenses: expeneses, category: Category.travel),
      ExpenseBucket.ofCategory(allExpenses: expeneses, category: Category.work),
    ];
  }



  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalAmount > maxTotalExpense) {
        maxTotalExpense = bucket.totalAmount;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalAmount == 0
                        ? 0
                        : bucket.totalAmount / maxTotalExpense,
                  ),
              ]),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets.map((bucket) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      categoryIcons[bucket.category],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                    ),
                  ),
                );
              }).toList(),
            )
          ]),
    );
  }
}
