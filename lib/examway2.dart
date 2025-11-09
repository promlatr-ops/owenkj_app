import 'package:flutter/material.dart';

/// ExamWay2 — Part: LAB (คะแนน 20)
///
/// คำอธิบาย: หน้าที่เกี่ยวกับการออกแบบหน้า และการสร้างฟอร์ม/ปุ่มพื้นฐาน
/// มีตัวอย่าง starter code ให้ทดลองแก้และส่งงาน

class ExamWay2Page extends StatelessWidget {
  static const routeName = '/examway2';
  const ExamWay2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExamWay 2 — LAB (20 คะแนน)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Part 2: LAB — รวม 20 คะแนน',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
                'ข้อ 1 — ออกแบบหน้าจอ (6 คะแนน)\n- ให้วาดหรืออธิบายโครงหน้าจอ ได้แก่ header, content, footer\n- ระบุ widget หลักที่ใช้ เช่น Column, Row, Expanded, Image, Text, Button'),
            const SizedBox(height: 12),
            const Text(
                'ข้อ 2 — ฟอร์มรับตัวเลขและบวกผล (7 คะแนน)\n- สร้างฟอร์ม 2 ช่องรับตัวเลข (TextField keyboardType: number)\n- มีปุ่ม "คำนวณ" เมื่อกดให้แสดงผลผลรวมด้านล่าง\n- ตรวจสอบค่าเป็นตัวเลขและแสดง message หากไม่ถูกต้อง'),
            const SizedBox(height: 12),
            const Text(
                'ข้อ 3 — ทำหน้าจอเพิ่มเติม (7 คะแนน)\n- เพิ่ม UI ให้ผลลัพธ์ดูดีขึ้น เช่น Card แสดงผล, ปุ่มรีเซ็ต, validation\n- (เลือก) เพิ่ม dropdown สำหรับเลือกการกระทำ (บวก, ลบ, คูณ, หาร)'),
            const SizedBox(height: 18),
            const Text('Starter UI (ตัวอย่าง):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('ตัวอย่างโครงร่างหน้าจอ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('- AppBar: ชื่อแบบฝึกหัด'),
                    Text(
                        '- Body: Column -> 2 TextField (รับตัวเลข) -> Row(ปุ่มคำนวณ/รีเซ็ต)'),
                    Text('- ผลลัพธ์: Text ขนาดใหญ่ใต้ปุ่ม'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: const Text('กลับหน้าหลัก'),
            ),
          ],
        ),
      ),
    );
  }
}
