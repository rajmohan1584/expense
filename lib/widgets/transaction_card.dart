import 'package:expense/transation.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  late Transaction tx;
  TransactionCard(this.tx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 5,
      child: Row(children: [buildPrice(), buildTitle()]),
    );
  }

  Widget buildPrice() {
    return Container(
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: Text(tx.amount.toString()));
  }

  Widget buildTitle() {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(tx.title), Text(tx.date.toString())],
        ));
  }
}
