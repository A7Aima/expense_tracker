import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/screens/new_transaction.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/screens/body_of_the_app.dart';
import 'package:expense_tracker/database/transaction_dao.dart';
import 'package:sembast/timestamp.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactions = [];
  bool _showChart = false;
  TransactionDAO trdao = TransactionDAO();

  void initializeList() async {
    _userTransactions = await TransactionDAO().getAllSortedByTitle();
    setState(() {
      //print('initialization complete');
    });
  }

  @override
  void initState() {
    super.initState();
    initializeList();
  }

  @override
  void dispose() async {
    await TransactionDAO().closeDb;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final pageBody = BodyOfTheApp(
      isLandscape: isLandscape,
      showChart: _showChart,
      mediaQuery: mediaQuery,
      userTransactions: _userTransactions,
      deleteTransaction: _deleteTransaction,
      recentTransaction: _recentTransaction,
      appBar: _appBar(),
      chartToggle: _chartToggle,
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: _appBar(),
          )
        : Scaffold(
            appBar: _appBar(),
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddnewTask(context),
                    child: Icon(Icons.add),
                    //backgroundColor: Colors.purple,
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: pageBody,
          );
  }

  void _chartToggle(bool val) {
    setState(() {
      _showChart = val;
    });
  }

  List<Transaction> get _recentTransaction {
    // print("Print Executes");
    return _userTransactions.where((trx) {
      return trx.date.toDateTime().isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          );
    }).toList();
  }

  void _addNewTransaction(
      {String title, double amount, DateTime choosenDate}) async {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: Timestamp.fromMillisecondsSinceEpoch(
          choosenDate.millisecondsSinceEpoch),
    );
    await TransactionDAO().insert(newTx);
    _userTransactions = await TransactionDAO().getAllSortedByTitle();
    setState(() {
      //print(_userTransactions);
    });
  }

  void _startAddnewTask(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: ctx,
      builder: (bCtx) {
        return NewTransaction(addNewTransaction: _addNewTransaction);
      },
    );
  }

  void _deleteTransaction(Transaction tx) async {
    await TransactionDAO().delete(tx);
    _userTransactions = await TransactionDAO().getAllSortedByTitle();
    setState(() {});
  }

  Widget _appBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expenses Tracker'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddnewTask(context),
                ),
              ],
            ),
          )
        : AppBar(
            //backgroundColor: Colors.purple,
            title: Text('Expenses Tracker'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddnewTask(context),
              )
            ],
          );
  }
}
