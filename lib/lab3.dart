import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Lab3: Fetch weather from API (goweather)
class Lab3Page extends StatefulWidget {
  static const routeName = '/lab3';
  const Lab3Page({Key? key}) : super(key: key);

  @override
  State<Lab3Page> createState() => _Lab3PageState();
}

class _Lab3PageState extends State<Lab3Page> {
  final TextEditingController _cityController =
      TextEditingController(text: 'Bangkok');
  Map<String, dynamic>? _data;
  bool _loading = false;
  String? _error;

  Future<void> _fetchWeather(String city) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final uri = Uri.parse('https://goweather.herokuapp.com/weather/\$city');
      final res = await http.get(uri).timeout(const Duration(seconds: 8));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        setState(() {
          _data = json as Map<String, dynamic>;
        });
      } else {
        setState(() => _error = 'Server responded ${res.statusCode}');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 3 — Weather API')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _fetchWeather(_cityController.text.trim()),
                  child: const Text('Fetch'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                    onPressed: () => setState(() {
                          _data = null;
                          _error = null;
                        }),
                    child: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 16),
            if (_loading) const CircularProgressIndicator(),
            if (_error != null)
              Text('Error: \\$_error',
                  style: const TextStyle(color: Colors.red)),
            if (_data != null) ...[
              Text('City: \\${_data!['city']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Temperature: \\${_data!['temperature'] ?? 'N/A'}'),
              Text(
                  'Description: \\${_data!['description'] ?? _data!['wind'] ?? ''}'),
              const SizedBox(height: 12),
              const Text('Forecast:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.from(
                      ((_data!['forecast'] ?? []) as List).map((f) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(f['day'] ?? ''),
                                  const SizedBox(height: 6),
                                  Text('${f['temp'] ?? ''}'),
                                ],
                              ),
                            ),
                          ))),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
