import 'package:flutter/material.dart';

/// Lab1: Design a simple screen (Instructions)
///
/// Detailed task (Part of LAB, 20 คะแนน total split across 3 labs):
/// - This lab focuses on UI design and planning. Students must provide a
///   concise written/wireframe design for a simple app.
///
/// Deliverables:
/// 1) A one-page design description (bullet points or short paragraphs).
/// 2) A simple wireframe drawn as ASCII/text (or described in bullets) that
///    shows the main widgets per screen.
/// 3) A short data model and API endpoint list (what data the app needs).
///
/// Scoring (6 คะแนน for this lab):
/// - Completeness of screens and flow (3 pts)
/// - Correct choice of widgets for each element (2 pts)
/// - Clarity of data model / endpoints (1 pt)

class Lab1Page extends StatelessWidget {
  static const routeName = '/lab1';
  const Lab1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 1 — Design Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('ข้อ 1 — ออกแบบหน้าจอ (6 คะแนน)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('คำชี้แจง (รายละเอียด):\n'
                '- ให้ออกแบบแอพขนาดเล็ก (ประมาณ 2–4 หน้า) เช่น แอพสภาพอากาศ, แอพร้านอาหาร, หรือแอพบันทึกงาน\n'
                '- อธิบายแต่ละหน้าเป็นข้อ ๆ และระบุ widget หลักที่จะใช้ (เช่น AppBar, ListView, Card, Image, Text, Button, Form)\n'
                '- ระบุ data model อย่างย่อ (field สำคัญ ๆ) และตัวอย่าง endpoint ถ้ามี\n'),
            const SizedBox(height: 12),
            const Text('ตัวอย่างคำตอบ (ตัวอย่างสั้น):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('- แอพสภาพอากาศ (WeatherApp):'),
            const Text(
                '  1) หน้า Home: AppBar(title), SearchBar, ListView ของเมืองที่บันทึกไว้ (แต่ละรายการเป็น Card) — Widget: AppBar, TextField, ListView, Card, IconButton'),
            const Text(
                '  2) หน้ารายละเอียด: แสดงชื่อเมือง, อุณหภูมิปัจจุบัน, สภาพ, แผนภูมิ forecast — Widget: Column, Text, Image, ListView'),
            const Text(
                '  3) หน้าการตั้งค่า: เปลี่ยนหน่วย °C/°F — Widget: SwitchListTile'),
            const SizedBox(height: 8),
            const Text(
                'Data model (ตัวอย่าง): { city: string, temperature: number, condition: string, forecast: [{day, temp}] }'),
            const SizedBox(height: 8),
            const Text(
                'API endpoints (ตัวอย่าง): GET /weather?city={city} -> returns JSON'),
            const SizedBox(height: 18),
            const Text('เกณฑ์การให้คะแนน (ตัวอย่าง):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('- ความสมบูรณ์ของโครงร่างและ flow: 3 คะแนน'),
            const Text('- ความเหมาะสมของ widget ที่เลือก: 2 คะแนน'),
            const Text('- ความชัดเจนของ data model/endpoints: 1 คะแนน'),
            const SizedBox(height: 18),
            const Text('คำแนะนำการส่งงาน:'),
            const Text(
                '- เขียนเป็นข้อ ๆ ให้กระชับและชัดเจน (ไม่จำเป็นต้องวาดรูปจริง แต่บรรยายโครงร่างได้)\n- ระบุตัวอย่าง JSON ที่คาดว่าจะได้จาก API (ถ้ามี)'),
          ],
        ),
      ),
    );
  }
}
