import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoSharePreferences extends StatefulWidget {
  const DemoSharePreferences({super.key});

  @override
  State<DemoSharePreferences> createState() => _DemoSharePreferencesState();
}

class _DemoSharePreferencesState extends State<DemoSharePreferences> {
  String user = "";
  String department = "";

  void setPersonalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", "Dev..");
    prefs.setString("department", "computer");
  }

  void getPersonalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString("user") ?? "";
      department = prefs.getString("department") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Personal Data")),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('User : $user'),
          SizedBox(height: 10),
          Text('Department : $department'),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                setPersonalData();
              },
              child: Text('Set Data')),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                getPersonalData();
              },
              child: Text('Read Data'))
        ])));
  }
}
