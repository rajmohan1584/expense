import 'dart:ui';

import 'package:expense/transation.dart';
import 'package:expense/util/format.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  late Transaction tx;
  late int minLen;
  TransactionCard(this.tx, this.minLen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 5,
      child: Row(children: [buildPrice(context), buildTitle()]),
    );
  }

  Widget buildPrice(BuildContext context) {
    String amt = FMT.amount(tx.amount);
    return Container(
        width: 100,
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor)),
        child: Text(amt.padLeft(minLen, ' '),
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFeatures: [FontFeature.tabularFigures()])));
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
