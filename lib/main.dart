import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Scorer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Magic Scorer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _playerIDOne = 1;
  int _playerIDTwo = 2;
  int _playerOne = 0;
  int _playerTwo = 0;
  int _dice = 0;

  void _increment(int who) {
    bool isPlayerOne = who == 1;
    int player = (who == 1 ? _playerOne : _playerTwo);
    setState(() {
      player++;
      if (isPlayerOne) {
        _playerOne = player;
      } else {
        _playerTwo = player;
      }
    });
  }


  void _decrement(int who) {
    bool isPlayerOne = who == 1;
    int player = (isPlayerOne ? _playerOne : _playerTwo);
    setState(() {
      if (player > 0) {
        player--;
        if (isPlayerOne) {
          _playerOne = player;
        } else {
          _playerTwo = player;
        }
      }
    });
  }

  int _rollDice() {
    Random rng = Random();
    return (rng.nextInt(6) + 1);
  }

  void _setDice() {
    for (int i = 0; i < 10; ++i) {
      setState(() {
        _dice = _rollDice();
      });
      sleep(Duration(microseconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RotatedBox(
              quarterTurns: 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        _increment(_playerIDOne);
                      },
                      child: Icon(Icons.add),
                    ),
                    Text(
                      '$_playerOne',
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _decrement(_playerIDOne);
                      },
                      child: Icon(Icons.remove),
                    ),
                  ]
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    color: Colors.redAccent,
                    child: Text(
                      _dice.toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1,
                    ),
                    onPressed: _setDice,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      _increment(_playerIDTwo);
                    },
                    child: Icon(Icons.add),
                  ),
                  Text(
                    '$_playerTwo',
                    style: Theme
                        .of(context)
                        .textTheme
                        .display1,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _decrement(_playerIDTwo);
                    },
                    child: Icon(Icons.remove),
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }
}
