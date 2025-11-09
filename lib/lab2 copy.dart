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

class Lab2Page extends StatefulWidget {
  static const routeName = '/lab2';
  const Lab2Page({Key? key}) : super(key: key);

  @override
  State<Lab2Page> createState() => _Lab2PageState();
}

class _Lab2PageState extends State<Lab2Page> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  String _operation = 'add';
  double? _result;

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;
    final a = double.parse(_aController.text.trim());
    final b = double.parse(_bController.text.trim());
    double res;
    switch (_operation) {
      case 'add':
        res = a + b;
        break;
      case 'sub':
        res = a - b;
        break;
      case 'mul':
        res = a * b;
        break;
      case 'div':
        res = b != 0 ? a / b : double.nan;
        break;
      default:
        res = 0;
    }
    setState(() {
      _result = res;
    });
  }

  void _reset() {
    _aController.clear();
    _bController.clear();
    setState(() {
      _result = null;
      _operation = 'add';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 2 — Calculator (Form)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                  'คำชี้แจง: สร้างฟอร์มรับตัวเลขสองค่า และคำนวณผลโดยมีตัวเลือกการกระทำ',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              TextFormField(
                controller: _aController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'ตัวเลขที่ 1'),
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
                decoration: const InputDecoration(labelText: 'ตัวเลขที่ 2'),
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
                  const Text('Operation: '),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _operation,
                    items: const [
                      DropdownMenuItem(value: 'add', child: Text('บวก')),
                      DropdownMenuItem(value: 'sub', child: Text('ลบ')),
                      DropdownMenuItem(value: 'mul', child: Text('คูณ')),
                      DropdownMenuItem(value: 'div', child: Text('หาร')),
                    ],
                    onChanged: (v) => setState(() => _operation = v ?? 'add'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: _calculate, child: const Text('คำนวณ'))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: OutlinedButton(
                          onPressed: _reset, child: const Text('รีเซ็ต'))),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: _result == null
                        ? const Text('รอการคำนวณ',
                            style: TextStyle(fontSize: 18))
                        : Text('ผลลัพธ์: ${_result!.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('กลับ')),
            ],
          ),
        ),
      ),
    );
  }
}
