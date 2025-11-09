import 'package:flutter/material.dart';

/// Assignment 2: Concert Ticket UI
class Assignment2Page extends StatelessWidget {
  static const routeName = '/assignment22';

  const Assignment2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concert Ticket'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              // Main Row content
              Row(
                children: [
                  // Left info (flex:3)
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Flutter Live',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text('Band: The Scaffolds'),
                          SizedBox(height: 4),
                          Text('Date: 9 NOV 2025'),
                          SizedBox(height: 4),
                          Text('Gate: 7'),
                        ],
                      ),
                    ),
                  ),

                  // Right barcode area (flex:1)
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.qr_code,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Tear indicator (positioned)
              const Positioned(
                top: 0,
                bottom: 0,
                left: 210,
                child: Center(
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
