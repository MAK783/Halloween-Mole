import 'package:flutter/material.dart';
import 'dart:math';

const ghost = "/Users/mattkad/Desktop/Projects/halloween/assets/ghost.jpeg";
const jack = "/Users/mattkad/Desktop/Projects/halloween/assets/jack.webp";

void main() {
  runApp(const MyApp());
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => NewHome();
}

class NewHome extends State<Home> {
  int scares = 0;
  List<bool> status = [
    true,
    false,
    true,
    false,
    false,
    false,
    false,
    true,
    false,
    false,
    false,
  ];

  void click(int i) {
    setState(() {
      if (status[i]) {
        scares++;
        bool notFound = true;
        while (notFound) {
          int rand = Random().nextInt(10);
          if (!status[rand]) {
            status[rand] = true;
            notFound = false;
          }
        }
        status[i] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int x = 1 + random.nextInt(15);
    if (scares >= x + 4) {
      return Image.asset(ghost);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Scares: $scares"),
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Table(children: [
        TableRow(children: [box(0), box(1)]),
        TableRow(children: [box(2), box(3)]),
        TableRow(children: [
          box(4),
          box(5),
        ]),
        TableRow(children: [box(6), box(7)]),
        TableRow(children: [box(8), box(9)])
      ], defaultColumnWidth: const FixedColumnWidth(200.0))),
    );
  }

  Widget box(int point) {
    return GestureDetector(
        onTap: () {
          click(point);
        },
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(1.25),
                child: Visibility(
                    visible: status[point],
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: const SizedBox(
                        child: Image(image: AssetImage(jack)))))));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Home(title: 'Spooky Game'),
    );
  }
}
