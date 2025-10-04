import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_list_page.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;
  final String baseUrl;

  const ProductFormPage({super.key, this.product, required this.baseUrl});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtl;
  late TextEditingController _subtitleCtl;
  late TextEditingController _priceCtl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameCtl = TextEditingController(text: widget.product?.name ?? '');
  _subtitleCtl = TextEditingController(text: widget.product?.description ?? '');
    _priceCtl = TextEditingController(text: widget.product?.price.toString() ?? '0');
  }

  @override
  void dispose() {
    _nameCtl.dispose();
  _subtitleCtl.dispose();
    _priceCtl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final name = _nameCtl.text.trim();
  final description = _subtitleCtl.text.trim();
    final price = double.tryParse(_priceCtl.text.trim()) ?? 0.0;

    try {
      if (widget.product == null) {
        // create
        final res = await http.post(Uri.parse('${widget.baseUrl}/products'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'name': name, 'description': description, 'price': price}));
        if (res.statusCode == 201 || res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('สร้างสินค้าเรียบร้อย')));
          Navigator.of(context).pop(true);
        } else {
          _showError('สร้างไม่สำเร็จ: HTTP ${res.statusCode}\n${res.body}');
        }
      } else {
        // update
        final id = widget.product!.id;
    final res = await http.put(Uri.parse('${widget.baseUrl}/products/$id'),
      headers: {'Content-Type': 'application/json'}, body: json.encode({'name': name, 'description': description, 'price': price}));
        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('แก้ไขสินค้าเรียบร้อย')));
          Navigator.of(context).pop(true);
        } else {
          _showError('แก้ไขไม่สำเร็จ: HTTP ${res.statusCode}\n${res.body}');
        }
      }
    } catch (e) {
      _showError('เกิดข้อผิดพลาด: ${e.toString()}');
    } finally {
      setState(() => _saving = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Product' : 'Create Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _nameCtl, decoration: const InputDecoration(labelText: 'Name'), validator: (v) => v == null || v.isEmpty ? 'Required' : null),
              TextFormField(controller: _subtitleCtl, decoration: const InputDecoration(labelText: 'Description')),
              TextFormField(controller: _priceCtl, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              _saving ? const CircularProgressIndicator() : ElevatedButton(onPressed: _save, child: Text(isEdit ? 'Update' : 'Create'))
            ],
          ),
        ),
      ),
    );
  }
}
