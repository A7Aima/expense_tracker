import 'package:flutter/material.dart';

final appBarThemeData = AppBarTheme(
  textTheme: ThemeData.light().textTheme.copyWith(
        button: TextStyle(color: Colors.white),
        headline6: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
);

final primaryThemeData = ThemeData.light().textTheme.copyWith(
      button: TextStyle(color: Colors.white),
      headline6: TextStyle(
        fontFamily: "OpenSans",
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
