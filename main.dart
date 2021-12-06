// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_xo/soloplayer.dart';
import 'home_page.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: Mainpage(),
  ));
}

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool page = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*initialRoute: '/',
      routes: {
        '/': (context) => const Mainpage(),
        '/HomePage': (context) => const HomePage(),
      },*/
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
