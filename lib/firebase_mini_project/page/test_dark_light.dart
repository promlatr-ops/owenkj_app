import 'package:flutter/material.dart';

class TestDarkLight extends StatelessWidget {
  final VoidCallback switchMode;
  const TestDarkLight({super.key, required this.switchMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Dark/Light')),
      body: Center(
        child: ElevatedButton(
          onPressed: switchMode,
          child: const Text('Toggle Theme'),
        ),
      ),
    );
  }
}
