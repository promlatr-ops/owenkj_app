import 'package:flutter/material.dart';

class TestDarkLight extends StatefulWidget {
  final Function switchMode;
  const TestDarkLight({super.key, required this.switchMode});

  @override
  State<TestDarkLight> createState() => _TestDarkLightState();
}

class _TestDarkLightState extends State<TestDarkLight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Switch Mode Theme')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello World'),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    widget.switchMode();
                  },
                  child: Text('Switch mode'))
            ],
          ),
        ));
  }
}
