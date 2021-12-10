// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, unnecessary_new, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_xo/main.dart';
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
      listButton[i].clr = Colors.blueGrey;
    }
    player1 = [];
    player2 = [];
    gamestr = "Play your turn";
  }

  bool checkWinner(var player) {
    if (player.contains(0) && player.contains(1) && player.contains(2))
      return true;
    if (player.contains(3) && player.contains(4) && player.contains(5))
      return true;
    if (player.contains(6) && player.contains(7) && player.contains(8))
      return true;
    if (player.contains(0) && player.contains(3) && player.contains(6))
      return true;
    if (player.contains(1) && player.contains(4) && player.contains(7))
      return true;
    if (player.contains(2) && player.contains(5) && player.contains(8))
      return true;
    if (player.contains(0) && player.contains(4) && player.contains(8))
      return true;
    if (player.contains(2) && player.contains(4) && player.contains(6))
      return true;

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
        //turn = true;
      }
    } else {
      if (listButton[index].enabled) {
        listButton[index].str = 'O';
        listButton[index].enabled = false;
        listButton[index].clr = Colors.blue;
        player2.add(index);
      }
    }

    if (checkWinner(player1)) {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.blueGrey;
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

    // player 2

    turn = !turn;
    if (checkWinner(player2)) {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.blueGrey;
      }
      // to calculate how many times the player wins
      player2w++;
      gamestr = "Player two for $player2w time";
      showDialog(
        context: context,
        builder: (BuildContext context) => _winnerwidget(context),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
            flex: 10,
            child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      listButton[index].str,
                      style: new TextStyle(color: Colors.white, fontSize: 60.0),
                    ),
                    color: listButton[index].clr,
                    disabledColor: Colors.grey,
                    onPressed: () {
                      setState(() {
                        if (listButton[index].enabled) {
                          playGame(index);
                        }
                      });
                    },
                  );
                })),
        Expanded(
          flex: 3,
          child: Text(
            '$gamestr',
            textAlign: TextAlign.start,
            style: new TextStyle(color: Colors.black, fontSize: 40.0),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Text("reset"),
        backgroundColor: Colors.red[800],
        onPressed: () {
          setState(() {
            reset();
          });
        },
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
