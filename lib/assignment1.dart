import 'package:flutter/material.dart';

/// Assignment 1: Comment Card UI (social-style thread)
class Assignment1Page extends StatelessWidget {
  static const routeName = '/assignment1';

  const Assignment1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment Thread'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ส่วนที่ 1: ความคิดเห็นหลัก
                Row(
                  children: [
                    CircleAvatar(radius: 24, child: Text('A')),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User A',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                              'This is the main comment. Flutter layouts are fun!'),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // ส่วนที่ 2: แถบเครื่องมือ
                Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, size: 18),
                    Text(' 12'),
                    SizedBox(width: 20),
                    Icon(Icons.comment_outlined, size: 18),
                    Text(' Reply'),
                    Spacer(),
                    Text('1h ago', style: TextStyle(color: Colors.grey)),
                  ],
                ),

                SizedBox(height: 12),

                // ส่วนที่ 3: การตอบกลับ (เยื้องเข้ามา)
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 18, child: Text('B')),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User B',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text('I agree!'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
