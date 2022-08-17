import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        ? Column(
            children: [
              Text(
                'No Transactions added yet.',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: transactons.length,
            itemBuilder: (context, index) {
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
                          '\$ ${transactons[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactons[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMEEEEd().format(transactons[index].date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    color: Theme.of(context).errorColor,
                    onPressed: () =>
                        deleteTransaction(txId: transactons[index].id),
                    icon: const Icon(
                      Icons.delete_forever,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
