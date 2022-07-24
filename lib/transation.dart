import 'package:flutter/foundation.dart';

class Transaction {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}

class Transactions {
  final List<Transaction> txs = [];

  int get count => txs.length;

  void add(String title, double amount, {DateTime? date}) {
    date ??= DateTime.now();
    final tx = Transaction(id: 0, title: title, amount: amount, date: date);
    txs.add(tx);
  }

  Transaction txAt(int index) => txs[index];
}
