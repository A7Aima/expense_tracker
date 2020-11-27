import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'chart.dart';
import 'transaction_list.dart';

class BodyOfTheApp extends StatelessWidget {
  final bool isLandscape;
  final bool showChart;
  final mediaQuery;
  final List<Transaction> userTransactions;
  final Function deleteTransaction;
  final List<Transaction> recentTransaction;
  final Function chartToggle;
  final PreferredSizeWidget appBar;
  BodyOfTheApp({
    @required this.isLandscape,
    @required this.showChart,
    @required this.mediaQuery,
    @required this.userTransactions,
    @required this.deleteTransaction,
    @required this.recentTransaction,
    @required this.appBar,
    @required this.chartToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart",
                      style: Theme.of(context).textTheme.headline6),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: showChart,
                    onChanged: (val) => chartToggle(val),
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(recentTransaction: recentTransaction),
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(
                  transactionsList: userTransactions,
                  deleteTransaction: deleteTransaction,
                ),
              ),
            if (isLandscape)
              showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(recentTransaction: recentTransaction),
                    )
                  : Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          1,
                      child: TransactionList(
                        transactionsList: userTransactions,
                        deleteTransaction: deleteTransaction,
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
