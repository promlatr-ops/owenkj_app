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
import 'examway1.dart';
import 'examway2.dart';
import 'examway3.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Use path URL strategy so routes appear like /products instead of /#/products
  try {
    setPathUrlStrategy();
  } catch (_) {}
  // Load dotenv from assets so it works on web and other platforms
  // For web AssetBundle automatically prefixes 'assets/', so pass just '.env'
  dotenv.load(fileName: '.env').then((_) => runApp(const MyApp()));
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
        PostList.routeName: (c) => const PostList(),
        ExamWay1Page.routeName: (c) => const ExamWay1Page(),
        ExamWay2Page.routeName: (c) => const ExamWay2Page(),
        ExamWay3Page.routeName: (c) => const ExamWay3Page(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home (Launcher)',
              style: TextStyle(color: Colors.white))),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'App Launcher',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(240, 56)),
                onPressed: () =>
                    Navigator.pushNamed(context, Assignment1Page.routeName),
                child: const Text('Open Assignment 1',
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(240, 56)),
                onPressed: () =>
                    Navigator.pushNamed(context, Assignment2Page.routeName),
                child: const Text('Open Assignment 2',
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(240, 56)),
                onPressed: () =>
                    Navigator.pushNamed(context, PostList.routeName),
                child: const Text('Open Assignment 3',
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/air'),
                child: const Text('Open Air Quality Page'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/products'),
                child: const Text('Open Product List Page'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushNamed(context, Assignment1Page.routeName),
        label: const Text('View A1'),
        icon: const Icon(Icons.open_in_new),
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
