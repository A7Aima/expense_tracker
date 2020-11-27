import 'dart:math';
import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColor = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.amber,
    ];
    _bgColor = availableColor[Random().nextInt(availableColor.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildCard(context);
  }

  Card buildCard(BuildContext context) {
    return Card(
      //key: widget.key,
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: buildAmountDisplay(),
        title: buildTitle(context),
        subtitle: buildDateReg(),
        trailing: deleteButtons(context),
      ),
    );
  }

  Text buildDateReg() {
    return Text(
      DateFormat.yMMMMd().format(widget.transaction.date.toDateTime()),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 10,
        color: Colors.grey,
      ),
    );
  }

  Text buildTitle(BuildContext context) {
    return Text(
      widget.transaction.title,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  CircleAvatar buildAmountDisplay() {
    return CircleAvatar(
      radius: 30,
      backgroundColor: _bgColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: Text(
            "₹${widget.transaction.amount.toStringAsFixed(2)}",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget deleteButtons(BuildContext context) {
    return MediaQuery.of(context).size.width > 400
        ? FlatButton.icon(
            icon: Icon(Icons.delete),
            label: Text("Delete"),
            textColor: Theme.of(context).errorColor,
            onPressed: () => widget.deleteTransaction(widget.transaction),
          )
        : IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () => widget.deleteTransaction(widget.transaction),
          );
  }
}
