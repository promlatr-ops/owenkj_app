import 'package:flutter/material.dart';
import 'dart:convert';

/// ExamWay3 — Part: LAB (API / JSON) (20 คะแนน)
///
/// คำอธิบาย: ให้เขียนโปรแกรมที่ดึงข้อมูลจาก JSON (ตัวอย่างให้) และแสดงผล
/// - ตัวอย่าง JSON เป็นข้อมูลสภาพอากาศอย่างง่าย (temperature, condition, city)
/// - คะแนน: ดึงค่า, แสดงใน UI, จัดรูปแบบสวยงาม

// ตัวอย่าง JSON string (จำลองการดึงมาจาก API)
const String sampleWeatherJson = '''
{
  "city": "Bangkok",
  "temperature": 31,
  "condition": "Sunny",
  "forecast": [
    {"day": "Mon", "temp": 31},
    {"day": "Tue", "temp": 30},
    {"day": "Wed", "temp": 29}
  ]
}
''';

class ExamWay3Page extends StatefulWidget {
  static const routeName = '/examway3';
  const ExamWay3Page({Key? key}) : super(key: key);

  @override
  State<ExamWay3Page> createState() => _ExamWay3PageState();
}

class _ExamWay3PageState extends State<ExamWay3Page> {
  late Map<String, dynamic> data;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    // จำลองการ fetch JSON
    Future.delayed(const Duration(milliseconds: 200), () {
      data = jsonDecode(sampleWeatherJson) as Map<String, dynamic>;
      setState(() {
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExamWay 3 — API/JSON')),
      body: Center(
        child: loaded
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data['city']}',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Temperature: ${data['temperature']} °C',
                            style: const TextStyle(fontSize: 18)),
                        Text('Condition: ${data['condition']}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 12),
                        const Text('Forecast:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: List<Widget>.from(
                              (data['forecast'] as List).map((f) => Expanded(
                                    child: Column(
                                      children: [
                                        Text(f['day']),
                                        const SizedBox(height: 6),
                                        Text('${f['temp']}°',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
