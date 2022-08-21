import 'package:flutter/material.dart';
import 'package:section04/widgets/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {Key? key, required this.transactons, required this.deleteTransaction})
      : super(key: key);

  final List<Transaction> transactons;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return transactons.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No Transactions added yet.',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactons.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                  transacton: transactons[index],
                  deleteTransaction: deleteTransaction);
            },
          );
  }
}
