import 'package:flutter/material.dart';
import 'package:section04/models/dummy_data.dart';
import 'package:section04/models/transaction.dart';
import 'package:section04/widgets/chart.dart';
import 'package:section04/widgets/new_transaction.dart';
import 'package:section04/widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<Transaction> _userTransactions = dummyTransactons;
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(
      {required String txTitle,
      required double txAmount,
      required DateTime txDate}) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: txDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return NewTransaction(
          addTransaction: _addNewTransaction,
        );
      },
    );
  }

  void _deleteTransaction({required String txId}) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == txId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Expenses'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add)),
      ],
    );

    print('${MediaQuery.of(context).size}');

    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            // chart
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.3,
            child: Chart(
              recentTransactions: _recentTransactions,
            ),
          ),
          SizedBox(
            // Transaction list
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.7,
            child: TransactionList(
              transactons: _userTransactions,
              deleteTransaction: _deleteTransaction,
            ),
          ),
        ],
      ),
    );
  }
}
