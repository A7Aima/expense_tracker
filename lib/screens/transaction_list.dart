import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_items.dart';
import 'package:expense_tracker/widgets/waiting_screen.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Function deleteTransaction;
  TransactionList({
    @required this.transactionsList,
    @required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return transactionsList.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrains) {
              return WaitingScreen(constrains: constrains);
            },
          )
        : ListView(
            children: transactionsList
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTransaction: deleteTransaction,
                    ))
                .toList(),
          );
  }
}
