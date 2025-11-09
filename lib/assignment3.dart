import 'package:flutter/material.dart';

/// Assignment 3: Simple page with a button that shows a SnackBar (Thai).
class Assignment3Page extends StatelessWidget {
  static const routeName = '/assignment3';

  const Assignment3Page({Key? key}) : super(key: key);

  void _showSnackbar(BuildContext context) {
    final snack = SnackBar(content: const Text('กดปุ่มแล้ว!'));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฝึกหัด 3'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSnackbar(context),
          child: const Text('กดฉัน'),
        ),
      ),
    );
  }
}
