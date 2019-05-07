import 'package:flutter/material.dart';
import 'package:dip2go/model/model.dart';
import 'package:dip2go/gamewidget/gamewidget.dart';

class GameDetailsPage extends StatefulWidget {
  final DipGame game;

  GameDetailsPage({Key key, @required this.game}) : super(key: key);

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  DipGame get _game => widget.game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_game.title),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: GameWidget(
                  fullscreen: false,
                  game: _game,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Text(_game.phase),
              )
            ),
          ],
        ),
    );
  }
}