// ignore_for_file: prefer_const_constructors, dead_code, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_xo/soloplayer.dart';
import 'home_page.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SoloPlayer()),
                  );
                },
                child: Container(
                  width: 110,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Vs Android  ',
                          style: TextStyle(fontFamily: 'MuseoModerno'),
                        ),
                      ),
                      Icon(Icons.android)
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Container(
                  width: 110,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Vs Friend ',
                          style: TextStyle(fontFamily: 'MuseoModerno'),
                        ),
                      ),
                      Icon(Icons.person)
                    ],
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
