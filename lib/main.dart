import 'dart:math';

import 'package:expense/transation.dart';
import 'package:expense/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(const ExpenseApp());
  var x = 0;
  if (x == 10) {
    x = x + 10;
  }
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialThemeData = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      //appBarTheme: AppBarTheme(color: Colors.amber.shade600),
      primarySwatch: Colors.pink,
      //secondaryHeaderColor: Colors.blue,
      //canvasColor: Colors.blue,
      //backgroundColor: Colors.red,
      //colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      //    .copyWith(secondary: Colors.blue),
    );

    final materialApp = MaterialAppData(theme: materialThemeData);

    const cupertinoTheme = CupertinoThemeData(
        primaryColor: Colors.blue,
        barBackgroundColor: Colors.amber,
        scaffoldBackgroundColor: Colors.white);

    final cupertinoApp = CupertinoAppData(theme: cupertinoTheme);

    return PlatformApp(
      title: "iOS Title",
      home: MyHomePage(),
      cupertino: ((context, target) => cupertinoApp),
      material: ((context, target) => materialApp),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final data = Transactions();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  int maxLen = 0;

  @override
  void initState() {
    data.add("Wendys", 12);
    data.add("Bucca", 75);
    data.add("Chomps", 15);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final amts = data.txs.map((e) => e.len);
    maxLen = 0;
    if (amts.isNotEmpty) maxLen = amts.reduce(max);

    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: const Text("Expense"),
          trailingActions: [
            PlatformIconButton(
              cupertinoIcon: const Icon(CupertinoIcons.add),
              materialIcon: const Icon(Icons.add),
              onPressed: () => onShowAddTx(context),
            )
          ],
        ),
        body: SafeArea(child: buildBody()));
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [buildChart(), buildList()],
    );
  }

  Widget buildChart() {
    return Card(elevation: 5, color: Colors.green, child: const Text("CHART"));
  }

  Widget buildList() {
    return Container(
        height: 300,
        child: ListView.builder(
          itemBuilder: buildTransaction,
          itemCount: data.count,
        ));
  }

  Widget buildTransaction(ctx, index) {
    Transaction tx = data.txAt(index);

    return TransactionCard(tx, maxLen);
  }

  addNewTx() {
    final title = titleController.text;
    final amount = amountController.text;
    final price = double.tryParse(amount) ?? 0;

    setState(() {
      data.add(title, price);
    });

    Navigator.of(context).pop();
  }

  ///////////////////////////////////////////
  /// Inputs
  ///
  onShowAddTx(BuildContext ctx) {
    showPlatformModalSheet(
        context: ctx,
        builder: (_) {
          return buildInputs();
        });
  }

  Widget buildInputs() {
    return SafeArea(
      child: SizedBox(
        height: 700,
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PlatformTextField(
                      hintText: "Item",
                      controller: titleController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PlatformTextField(
                      hintText: "Price",
                      controller: amountController,
                    ),
                  ),
                  PlatformTextButton(
                    child: Text("Add"),
                    onPressed: () {
                      addNewTx();
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
