// ignore_for_file: prefer_const_constructors, unnecessary_new, dead_code, avoid_print

import 'package:flutter/material.dart';

import 'game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final title = 'Grid List';
  bool turn = false;
  var player1 = [];
  var player2 = [];
  String gamestr = 'Play your Turn';
  int player1w = 0;
  int player2w = 0;
  List listButton = <GameButton>[
    new GameButton(1),
    new GameButton(2),
    new GameButton(3),
    new GameButton(4),
    new GameButton(5),
    new GameButton(6),
    new GameButton(7),
    new GameButton(8),
    new GameButton(9)
  ];

  void reset() {
    for (int i = 0; i < 9; i++) {
      listButton[i].str = '';
      listButton[i].enabled = true;
      listButton[i].clr = Colors.white;
    }
    player1 = [];
    player2 = [];

    gamestr = "Play your turn";
  }

// to store the winning buttons
  late List winner = [];

  bool checkWinner(var player) {
    if (player.contains(0) && player.contains(1) && player.contains(2)) {
      winner = [
        0,
        1,
        2,
      ];
      return true;
    }
    if (player.contains(3) && player.contains(4) && player.contains(5)) {
      winner = [
        3,
        4,
        5,
      ];
      return true;
    }
    if (player.contains(6) && player.contains(7) && player.contains(8)) {
      winner = [
        6,
        7,
        8,
      ];
      return true;
    }
    if (player.contains(0) && player.contains(3) && player.contains(6)) {
      winner = [
        0,
        3,
        6,
      ];
      return true;
    }
    if (player.contains(1) && player.contains(4) && player.contains(7)) {
      winner = [
        1,
        4,
        7,
      ];
      return true;
    }
    if (player.contains(2) && player.contains(5) && player.contains(8)) {
      winner = [
        2,
        5,
        8,
      ];
      return true;
    }
    if (player.contains(0) && player.contains(4) && player.contains(8)) {
      winner = [
        0,
        4,
        8,
      ];
      return true;
    }
    if (player.contains(2) && player.contains(4) && player.contains(6)) {
      winner = [
        2,
        4,
        6,
      ];
      return true;
    }

    return false;
  }

  void playGame(int index) {
    // player 1
    if (turn) {
      if (listButton[index].enabled) {
        listButton[index].str = 'X';
        listButton[index].enabled = false;
        listButton[index].clr = Colors.red;
        player1.add(index);
      }
    } else {
      // to pass the turn tp the other player
      if (listButton[index].enabled) {
        listButton[index].str = 'O';
        listButton[index].enabled = false;
        listButton[index].clr = Colors.black;
        player2.add(index);
      }
    }

    if (checkWinner(player1)) {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.blueGrey;
      }
      for (var element in winner) {
        listButton[element].clr = Colors.red;
      }
      // to calculate how many times the player wins
      player1w++;
      gamestr = "Player one for $player1w  time";
      showDialog(
        context: context,
        // to build the winnerwidget that will popup in case he wins
        builder: (BuildContext context) => _winnerwidget(context),
      );

      return;
    }

    turn = !turn;
    if (checkWinner(player2)) {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.blueGrey;
      }
      for (var element in winner) {
        listButton[element].clr = Colors.black;
      }
      // to calculate how many times the player wins
      player2w++;
      // to show how many times the player wins in the popup
      gamestr = "Player two for $player2w time";

      showDialog(
        context: context,
        builder: (BuildContext context) => _winnerwidget(context),
      );
      return;
    }
    bool gameover = true;
    //to see if the game has ended
    for (int i = 0; i <= 8; i++) {
      if (listButton[i].enabled) {
        gameover = false;
      }
    }
    // to announce the draw
    if (gameover) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _winnerwidget(context),
      );
      gamestr = 'No One';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'MuseoModerno'),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Play Vs Friend"),
          centerTitle: true,
          backgroundColor: Colors.red[600],
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover)),
          child: Column(children: <Widget>[
            Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.only(bottom: 0),
                  margin: EdgeInsets.only(top: 60, bottom: 0),
                  child: GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.0,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return new FlatButton(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            listButton[index].str,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 60.0),
                          ),
                          color: listButton[index].clr,
                          //disabledColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (listButton[index].enabled) {
                                playGame(index);
                              }
                            });
                          },
                        );
                      }),
                )),
            Expanded(
              flex: 0,
              child: Text(
                'Player1: $player2w   $player1w :Player2',
                textAlign: TextAlign.start,
                style: new TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10, bottom: 30),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: () {
                      // to navigate to the startpage
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.home_outlined, size: 18),
                    label: Text("Home"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: () {
                      // to play again
                      setState(() {
                        reset();
                      });
                    },
                    icon: Icon(Icons.cached_outlined, size: 18),
                    label: Text("Play Again"),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

// the widget that will popup if a player wins
  Widget _winnerwidget(BuildContext context) {
    return new AlertDialog(
      title: const Text('The winner is'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(gamestr),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
