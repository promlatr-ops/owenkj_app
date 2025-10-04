import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_form_page.dart';

class Product {
  final int? id;
  final String name;
  final String description;
  final double price;

  Product({this.id, required this.name, required this.description, required this.price});

  factory Product.fromJson(Map<String, dynamic> j) {
    return Product(
      id: j['id'] is int ? j['id'] as int : (j['id'] is String ? int.tryParse(j['id']) : null),
      name: j['name'] ?? j['title'] ?? 'Unnamed',
      description: j['description'] ?? j['subtitle'] ?? '',
      price: (j['price'] is num) ? (j['price'] as num).toDouble() : double.tryParse('${j['price']}') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'description': description,
        'price': price,
      };
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final String baseUrl = 'http://localhost:8001';
  List<Product> _items = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() => _loading = true);
    try {
      final res = await http.get(Uri.parse('$baseUrl/products'));
      if (res.statusCode == 200) {
        final List<dynamic> list = json.decode(res.body) as List<dynamic>;
        _items = list.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        _showError('Failed to load products: HTTP ${res.statusCode}\n${res.body}');
      }
    } catch (e) {
      _showError('Error fetching products: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _createProduct(String name, String subtitle, double price) async {
    try {
  final p = Product(name: name, description: subtitle, price: price);
      final res = await http.post(Uri.parse('$baseUrl/products'),
          headers: {'Content-Type': 'application/json'}, body: json.encode(p.toJson()));
      if (res.statusCode == 201 || res.statusCode == 200) {
        // server returns created product
        await _fetchProducts();
      } else {
        _showError('Failed to create product: HTTP ${res.statusCode}\n${res.body}');
      }
    } catch (e) {
      _showError('Error creating product: ${e.toString()}');
    }
  }

  Future<void> _editProduct(Product p) async {
    final updated = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ProductFormPage(product: p, baseUrl: baseUrl)));
    if (updated == true) {
      await _fetchProducts();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('แก้ไขสินค้าเรียบร้อย')));
    }
  }

  Future<void> _deleteProduct(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Confirm delete'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [TextButton(onPressed: () => Navigator.of(c).pop(false), child: const Text('Cancel')), TextButton(onPressed: () => Navigator.of(c).pop(true), child: const Text('Delete'))],
      ),
    );
    if (confirmed != true) return;
    try {
      final res = await http.delete(Uri.parse('$baseUrl/products/$id'));
      if (res.statusCode == 200) {
        await _fetchProducts();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ลบข้อมูลเรียบร้อย')));
      } else {
        _showError('Failed to delete: HTTP ${res.statusCode}\n${res.body}');
      }
    } catch (e) {
      _showError('Error deleting product: ${e.toString()}');
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<bool?> _showCreateDialog() async {
    final nameCtl = TextEditingController();
    final subCtl = TextEditingController();
    final priceCtl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create product'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(controller: nameCtl, decoration: const InputDecoration(labelText: 'Name'), validator: (v) => (v == null || v.isEmpty) ? 'Required' : null),
              TextFormField(controller: subCtl, decoration: const InputDecoration(labelText: 'Subtitle')),
              TextFormField(controller: priceCtl, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final name = nameCtl.text.trim();
                  final sub = subCtl.text.trim();
                  final price = double.tryParse(priceCtl.text.trim()) ?? 0.0;
                  Navigator.of(context).pop(true);
                  _createProduct(name, sub, price);
                }
              },
              child: const Text('Create'))
        ],
      ),
    );
    // clear controllers
    nameCtl.dispose();
    subCtl.dispose();
    priceCtl.dispose();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: RefreshIndicator(
        onRefresh: _fetchProducts,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Text('${index + 1}', style: const TextStyle(color: Colors.black54)),
                    ),
                    title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(item.description),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(item.price.toStringAsFixed(1), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      IconButton(onPressed: () => _editProduct(item), icon: const Icon(Icons.edit, color: Colors.blue)),
                      IconButton(onPressed: () => _deleteProduct(item.id ?? 0), icon: const Icon(Icons.delete, color: Colors.red)),
                    ]),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductFormPage(baseUrl: baseUrl)));
          if (created == true) {
            await _fetchProducts();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('เพิ่มข้อมูลสำเร็จ')));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
