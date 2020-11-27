import 'package:sembast/timestamp.dart';

import '../models/transaction.dart';
import '../widgets/chat_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:sembast/timestamp.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart({this.recentTransaction});

  List<Map<String, Object>> get groupTransaction {
    //print(recentTransaction.length);
    return List.generate(7, (index) {
      //print(index);
      final weekDay =
          Timestamp.now().toDateTime().subtract(Duration(days: (index)));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.toDateTime().day == weekDay.day &&
            recentTransaction[i].date.toDateTime().month == weekDay.month &&
            recentTransaction[i].date.toDateTime().year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransaction.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransaction.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
