import 'package:flutter/material.dart';
import 'package:dip2go/model/model.dart';

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
        body: Center(
          child: Text(_game.phase),
        ),
    );
  }
}