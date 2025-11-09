import 'package:flutter/material.dart';

/// Assignment 2: Simple page with an icon and a short instruction (Thai).
class Assignment2Page extends StatelessWidget {
  static const routeName = '/assignment2';

  const Assignment2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฝึกหัด 2'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.assignment, size: 64, color: Colors.blue),
            SizedBox(height: 12),
            Text(
              'นี่คือหน้า Assignment 2\n(ตัวอย่างไอคอนและคำอธิบาย)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
