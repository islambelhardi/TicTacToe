// ignore_for_file: deprecated_member_use, unnecessary_new, duplicate_ignore

import 'package:flutter/material.dart';
import 'game_button.dart';

class SoloPlayer extends StatefulWidget {
  @override
  SoloPlayerState createState() => SoloPlayerState();
}

class SoloPlayerState extends State<SoloPlayer> {
  final title = 'Grid List';

  var player1 = [];
  var player2 = [];
  String gamestr = 'Play your Turn';

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
    if (player.contains(0) && player.contains(1) && player.contains(2)) {
      return true;
    }
    if (player.contains(3) && player.contains(4) && player.contains(5)) {
      return true;
    }
    if (player.contains(6) && player.contains(7) && player.contains(8)) {
      return true;
    }
    if (player.contains(0) && player.contains(3) && player.contains(6)) {
      return true;
    }
    if (player.contains(1) && player.contains(4) && player.contains(7)) {
      return true;
    }
    if (player.contains(2) && player.contains(5) && player.contains(8)) {
      return true;
    }
    if (player.contains(0) && player.contains(4) && player.contains(8)) {
      return true;
    }
    if (player.contains(2) && player.contains(4) && player.contains(6)) {
      return true;
    }

    return false;
  }

  void playGame(int index) {
    // player 1
    if (listButton[index].enabled) {
      listButton[index].str = 'X';
      listButton[index].enabled = false;
      listButton[index].clr = Colors.red;

      player1.add(index);
    }

    if (checkWinner(player1)) {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.blueGrey;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) => _winnerwidget(context),
      );
      gamestr = "You";

      return;
    }

    // android plays smarter than before
    var allPlayedButtons = new List.from(player1)..addAll(player2);
    if (player1.contains(0) && player1.contains(1) && !player2.contains(2)) {
      if (!allPlayedButtons.contains(2)) {
        listButton[2].str = 'O';
        listButton[2].enabled = false;
        listButton[2].clr = Colors.blue;
        player2.add(2);
      }
    } else if (player1.contains(3) &&
        player1.contains(4) &&
        !player2.contains(5)) {
      if (!allPlayedButtons.contains(2)) {
        listButton[5].str = 'O';
        listButton[5].enabled = false;
        listButton[5].clr = Colors.blue;
        player2.add(5);
      }
    } else if (player1.contains(6) &&
        player1.contains(7) &&
        !player2.contains(8)) {
      if (!allPlayedButtons.contains(2)) {
        listButton[8].str = 'O';
        listButton[8].enabled = false;
        listButton[8].clr = Colors.blue;
        player2.add(8);
      }
    } else if (player1.contains(0) &&
        player1.contains(3) &&
        !player2.contains(6)) {
      if (!allPlayedButtons.contains(6)) {
        listButton[6].str = 'O';
        listButton[6].enabled = false;
        listButton[6].clr = Colors.blue;
        player2.add(6);
      }
    } else if (player1.contains(1) &&
        player1.contains(4) &&
        !player2.contains(7)) {
      if (!allPlayedButtons.contains(7)) {
        listButton[7].str = 'O';
        listButton[7].enabled = false;
        listButton[7].clr = Colors.blue;
        player2.add(7);
        ;
      }
    } else if (player1.contains(2) &&
        player1.contains(5) &&
        !player2.contains(8)) {
      if (!allPlayedButtons.contains(8)) {
        listButton[8].str = 'O';
        listButton[8].enabled = false;
        listButton[8].clr = Colors.blue;
        player2.add(8);
      }
    } else if (player1.contains(0) &&
        player1.contains(4) &&
        !player2.contains(8)) {
      if (!allPlayedButtons.contains(8)) {
        listButton[8].str = 'O';
        listButton[8].enabled = false;
        listButton[8].clr = Colors.blue;
        player2.add(8);
      }
    } else if (player1.contains(2) &&
        player1.contains(4) &&
        !player2.contains(6)) {
      if (!allPlayedButtons.contains(6)) {
        listButton[6].str = 'O';
        listButton[6].enabled = false;
        listButton[6].clr = Colors.blue;
        player2.add(6);
      }
    } else {
      var allPlayedButtons = new List.from(player1)..addAll(player2);
      for (int i = 0; i < 9; i++) {
        if (!allPlayedButtons.contains(i)) {
          listButton[i].str = 'O';
          listButton[i].enabled = false;
          listButton[i].clr = Colors.blue;
          player2.add(i);
          break;
        }
      }
    }

    if (checkWinner(player2)) {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.blueGrey;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) => _winnerwidget(context),
      );
      gamestr = "The computer";
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello world"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
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
        IconButton(
          icon: Icon(
            Icons.home_outlined,
          ),
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
    // ignore: unnecessary_new
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
