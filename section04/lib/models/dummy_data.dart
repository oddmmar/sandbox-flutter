import 'package:section04/models/transaction.dart';

final dummyTransactons = [
  Transaction(
    id: DateTime.now().toString(),
    title: 'New shoes',
    amount: 69.999,
    date: DateTime.now(),
  ),
  Transaction(
    id: DateTime.now().toString(),
    title: 'Groceries',
    amount: 109.858,
    date: DateTime.now(),
  ),
  Transaction(
    id: DateTime.now().toString(),
    title: 'Toys',
    amount: 899.99,
    date: DateTime.now(),
  ),
  Transaction(
    id: DateTime.now().toString(),
    title: 'Take Aways',
    amount: 50.05,
    date: DateTime.now(),
  ),
];
