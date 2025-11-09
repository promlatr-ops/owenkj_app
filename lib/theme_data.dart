import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey,
    appBarTheme: AppBarTheme(backgroundColor: Colors.blueAccent));

ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.blueGrey[800],
    appBarTheme: AppBarTheme(backgroundColor: Colors.blueAccent));
