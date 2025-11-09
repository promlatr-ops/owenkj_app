import 'package:firebase_core/firebase_core.dart';
import 'firebase_mini_project/constant/theme_data.dart';
import 'firebase_mini_project/firebase_data.dart';
import 'firebase_mini_project/firebase_test_crud.dart';
import 'firebase_mini_project/page/simple_custom_widget.dart';
import 'firebase_mini_project/page/test_dark_light.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // ค่าเริ่มต้นเป็น Light Mode

  void toggleTheme() {
    setState(() {
      _themeMode =
          (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: _themeMode, // set theme เปลี่ยนได้ตรงนี้

      darkTheme: darkTheme, //dark thme
      theme: lightTheme, //default thme

      home: TestDarkLight(switchMode: toggleTheme),
    );
  }
}
