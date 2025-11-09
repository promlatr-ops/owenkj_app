import 'package:flutter/material.dart';

/// Lab2: Functional calculator form (two numbers, operation, result)
///
/// Detailed instructions and expectations:
/// - Build a form with validation that accepts two numeric inputs.
/// - Provide a way to choose operation (add, subtract, multiply, divide).
/// - Show result in a clear card/area and handle divide-by-zero gracefully.
/// - Provide a reset button.
///
/// Scoring (7 คะแนน example):
/// - Validation and correctness (3 pts)
/// - UI/UX clarity (2 pts)
/// - Extra: operation selection and reset (2 pts)

class Assignment2Page extends StatefulWidget {
  static const routeName = '/assignment2';
  const Assignment2Page({Key? key}) : super(key: key);

  @override
  State<Assignment2Page> createState() => _Assignment2PageState();
}

class _Assignment2PageState extends State<Assignment2Page> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  double? _result;

  @override
  void _calculate() {
    final a = double.parse(_aController.text.trim());
    final b = double.parse(_bController.text.trim());
    double res;
    res = a / ((b / 100) * (b / 100));
    setState(() {
      _result = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('คำนวณ BMI')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              TextFormField(
                controller: _aController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'น้ำหนัก (กก.))'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'กรุณากรอกตัวเลข';
                  if (double.tryParse(v.trim()) == null)
                    return 'กรุณากรอกตัวเลขที่ถูกต้อง';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _bController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'ส่วนสูง (ซม.)'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'กรุณากรอกตัวเลข';
                  if (double.tryParse(v.trim()) == null)
                    return 'กรุณากรอกตัวเลขที่ถูกต้อง';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: _calculate, child: const Text('คำนวณ'))),
                  const SizedBox(width: 12),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: _result == null
                        ? const Text('ผลลัพธ์: -')
                        : Text('ผลลัพธ์: ${_result!.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
