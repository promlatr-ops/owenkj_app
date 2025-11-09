import 'package:flutter/material.dart';

// Minimal theme stubs so firebase_main.dart can reference them.
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey, brightness: Brightness.dark),
  useMaterial3: true,
);
