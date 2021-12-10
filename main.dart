// ignore_for_file: prefer_const_constructors, dead_code

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xo/soloplayer.dart';
import 'home_page.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: StartPage(),
  ));
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool page = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SoloPlayer()),
                );
              },
              child: Text('Play vs Computer'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text('Play vs Friend'),
            ),
          ],
        ),
      ),
    );
  }
}
