import 'dart:io';
import 'package:flutter/cupertino.dart';
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
  final List<Transaction> _userTransactions = dummyTransactons;
  // final List<Transaction> _userTransactions = [];

  bool _showChart = false;

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

  Widget _buildCupertinoAppBar() {
    return CupertinoNavigationBar(
      middle: const Text('Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: const Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAndroidAppBar() {
    return AppBar(
      title: const Text('Expenses'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = (Platform.isIOS
        ? _buildCupertinoAppBar()
        : _buildAndroidAppBar()) as ObstructingPreferredSizeWidget;

    final txWidget = SizedBox(
      // Transaction list
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom) *
          0.6,
      child: TransactionList(
        transactons: _userTransactions,
        deleteTransaction: _deleteTransaction,
      ),
    );

    Widget _buildLandscapeContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show Chart'),
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom) *
                0.2,
            child: Switch.adaptive(
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                }),
          ),
        ],
      );
    }

    Widget _buildPortraitContent() {
      return SizedBox(
        // chart
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom) *
            0.3,
        child: Chart(
          recentTransactions: _recentTransactions,
        ),
      );
    }

    final pageBody = Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLandscape) _buildLandscapeContent(),
        if (!isLandscape) _buildPortraitContent(),
        if (!isLandscape) txWidget,
        if (isLandscape)
          _showChart
              ? SizedBox(
                  // chart
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: Chart(
                    recentTransactions: _recentTransactions,
                  ),
                )
              : txWidget,
      ],
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            // ignore: unnecessary_cast
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
            body: pageBody,
          );
  }
}
