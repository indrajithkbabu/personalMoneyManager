import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalmoneymanager/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personalmoneymanager/widgets/chart.dart';
import 'package:personalmoneymanager/widgets/new_transaction.dart';
import 'package:personalmoneymanager/widgets/transaction_list.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    title: 'Personal Money Manager',
    theme: ThemeData(primarySwatch: Colors.purple),
    debugShowCheckedModeBanner: false,
    home: ScreenMoneyManager(),
  ));
}

class ScreenMoneyManager extends StatefulWidget {
  @override
  State<ScreenMoneyManager> createState() => _ScreenMoneyManagerState();
}

class _ScreenMoneyManagerState extends State<ScreenMoneyManager> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: "New Shoes", amount: 700, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: "New tshirt", amount: 500, date: DateTime.now()),
    // Transaction(id: 't3', title: "New jeans", amount: 700, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    } ).toList();
  }
  

  void _addNewTransactions(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate
        );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.55,
          child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransactions)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Money Manager"),
       // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
     Chart(_recentTransactions),
         // SizedBox(height: 230,),
          TransactionList(_userTransactions)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
