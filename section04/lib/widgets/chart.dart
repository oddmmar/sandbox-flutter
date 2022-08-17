import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:section04/models/transaction.dart';
import 'package:section04/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionsValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((e) {
            return Expanded(
              // fit: FlexFit.tight,
              child: ChartBar(
                  label: '${e['day']}',
                  spendingAmount: e['amount'] as double,
                  spendingPctAmount: maxSpending == 0.0
                      ? 0.0
                      : ((e['amount'] as double) / maxSpending)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
