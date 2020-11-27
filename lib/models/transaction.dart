import 'package:flutter/foundation.dart';
import 'package:sembast/timestamp.dart';

class Transaction {
  int id;
  final String title;
  final double amount;
  final Timestamp date;

  Transaction({
    //@required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "amount": amount,
      "date": date,
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      amount: map['amount'],
      title: map['title'],
      date: map['date'],
    );
  }
}
