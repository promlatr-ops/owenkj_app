import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Use path URL strategy for clean web URLs (no hash)
import 'package:url_strategy/url_strategy.dart';
// profile_card.dart is not used by default; keep the file but avoid importing it here
import 'pages/air_quality_page.dart';
import 'pages/product_list_page.dart';
import 'assignment1.dart';
import 'assignment2.dart';
import 'assignment3.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Use path URL strategy so routes appear like /products instead of /#/products
  try {
    setPathUrlStrategy();
  } catch (_) {}
  // Load dotenv from assets so it works on web and other platforms
  dotenv.load(fileName: 'assets/.env').then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (c) => const HomePage(),
        '/air': (c) => const AirQualityPage(),
        '/products': (c) => const ProductListPage(),
        Assignment1Page.routeName: (c) => const Assignment1Page(),
        Assignment2Page.routeName: (c) => const Assignment2Page(),
        Assignment3Page.routeName: (c) => const Assignment3Page(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/air'),
            child: const Text('Open Air Quality Page'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/products'),
            child: const Text('Open Product List Page'),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Assignment1Page.routeName),
            child: const Text('Open Assignment 1'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Assignment2Page.routeName),
            child: const Text('Open Assignment 2'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Assignment3Page.routeName),
            child: const Text('Open Assignment 3'),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Color Layout',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 120,
              height: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
              ),
            ),
            Positioned(
              top: 110,
              left: 20,
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.yellow),
              ),
            ),
            Positioned(
              top: 200,
              left: 20,
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          "https://avatars.githubusercontent.com/u/100008549?v=4",
          height: 500,
          width: 500,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
          onPressed: () {},
          child: const Text(
            'Button',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    )));
  }
}
