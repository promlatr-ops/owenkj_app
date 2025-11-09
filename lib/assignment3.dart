import 'package:flutter/material.dart';

/// Assignment 3: Car wash price calculator (Thai UI)
class Assignment3Page extends StatefulWidget {
  static const routeName = '/assignment3';

  const Assignment3Page({Key? key}) : super(key: key);

  @override
  State<Assignment3Page> createState() => _Assignment3PageState();
}

class _Assignment3PageState extends State<Assignment3Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _basePrice = 150; // default: Small
  bool _vacuum = false;
  bool _wax = false;
  int _total = 150;

  void _calculateTotal() {
    int total = _basePrice;
    if (_vacuum) total += 50;
    if (_wax) total += 100;
    setState(() {
      _total = total;
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('คํานวณค่าบริการล้างรถ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ขนาดรถ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // Dropdown for car size
              DropdownButton<int>(
                value: _basePrice,
                items: const [
                  DropdownMenuItem(
                      value: 150, child: Text('รถเล็ก (Small) - 150 บาท')),
                  DropdownMenuItem(
                      value: 200, child: Text('รถเก๋ง (Medium) - 200 บาท')),
                  DropdownMenuItem(
                      value: 250,
                      child: Text('รถ SUV/กระบะ (Large) - 250 บาท')),
                ],
                onChanged: (val) {
                  if (val == null) return;
                  setState(() {
                    _basePrice = val;
                    _calculateTotal();
                  });
                },
              ),

              const SizedBox(height: 12),
              const Text('บริการเสริม',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: const Text('ดูดฝุ่น (+50 บาท)'),
                value: _vacuum,
                onChanged: (val) {
                  setState(() {
                    _vacuum = val ?? false;
                    _calculateTotal();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: const Text('เคลือบแว็กซ์ (+100 บาท)'),
                value: _wax,
                onChanged: (val) {
                  setState(() {
                    _wax = val ?? false;
                    _calculateTotal();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Optionally validate form here; just calculate
                    _calculateTotal();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('คํา่ณวณแล้ว: ราคารวม $_total บาท')),
                    );
                  },
                  child: const Text('คํานวณราคา'),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Text(
                  'ราคารวม: $_total บาท',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
