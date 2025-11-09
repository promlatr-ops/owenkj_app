import 'package:flutter/material.dart';

/// ExamWay1 — Part: Lecture (คะแนน 20)
///
/// คำอธิบาย: ไฟล์นี้ประกอบด้วยชุดข้อสอบแบบ Lecture (ข้อกา/ข้อเขียน)
/// - รวมคำถามปรนัยแบบสั้นๆ และคำถามเชิงออกแบบระบบ/แอพ
/// - เหมาะจะใช้เป็นใบงานหรือข้อสอบในห้องเรียน

class ExamWay1Page extends StatelessWidget {
  static const routeName = '/examway1';
  const ExamWay1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExamWay 1 — Lecture (20 คะแนน)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text('Part 1: Lecture — รวม 20 คะแนน',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(
                'ข้อที่ 1 (ปรนัย/กา) — 5 คะแนน\n- REST API คืออะไร?\n- ให้เลือกคำตอบที่ถูกต้อง (ตัวอย่างตัวเลือก)\n'),
            SizedBox(height: 10),
            Text(
                'ข้อที่ 2 (ปรนัย/กา) — 5 คะแนน\n- HTTP method ต่างๆ (GET, POST, PUT, DELETE) ใช้ทำอะไรบ้าง?\n'),
            SizedBox(height: 10),
            Text(
                'ข้อที่ 3 (ข้อเขียน) — 10 คะแนน\n- ออกแบบแอพง่าย ๆ (วาดเป็นข้อความ/ลำดับหน้า):\n  * อธิบายว่าแอพมีหน้ากี่หน้า แต่ละหน้าทำอะไร\n  * ระบุองค์ประกอบหลัก (รายการ, ฟอร์ม, ปุ่ม, API ที่ใช้)\n  * วาดโครงร่างหน้าจอคร่าว ๆ (ใช้คำอธิบายหรือลิสต์)\n\nตัวอย่างคำตอบสั้น ๆ:\n  - แอพสั่งอาหาร: หน้าแรกแสดงรายการเมนู, หน้ารายละเอียดสินค้า, หน้าตะกร้าสินค้า, หน้าแจ้งชำระเงิน\n  - องค์ประกอบ: AppBar, ListView, Card, Image, Button, Form (TextField)\n'),
            SizedBox(height: 18),
            Text(
                'คำแนะนำสำหรับนักเรียน:\n- สำหรับข้อเขียน ให้เขียนเป็นข้อ ๆ และวาดโครงร่างโดยใช้คำอธิบาย\n- ให้ชี้แจง data model และ API endpoints ที่จำเป็น (แบบสั้น ๆ)\n',
                style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
