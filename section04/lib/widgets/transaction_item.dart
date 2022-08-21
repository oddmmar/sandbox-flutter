import 'package:flutter/material.dart';
import 'package:section04/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transacton,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transacton;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$ ${transacton.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transacton.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMEEEEd().format(transacton.date),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? ElevatedButton.icon(
                onPressed: () {
                  deleteTransaction(txId: transacton.id);
                },
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete'),
              )
            : IconButton(
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(txId: transacton.id),
                icon: const Icon(
                  Icons.delete_forever,
                ),
              ),
      ),
    );
  }
}
