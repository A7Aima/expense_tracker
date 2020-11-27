import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AddButton extends StatelessWidget {
  final Function presentDatePicker;

  AddButton({this.presentDatePicker});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              "Choose Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: presentDatePicker,
          )
        : FlatButton(
            onPressed: presentDatePicker,
            child: Text(
              "Choose Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: Theme.of(context).primaryColor,
          );
  }
}
