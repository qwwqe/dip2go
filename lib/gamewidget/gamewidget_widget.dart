import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:dip2go/model/model.dart';
import 'package:dip2go/gamewidget/gamewidget.dart';

class GameWidget extends StatefulWidget {
  final DipGame game;
  final bool fullscreen;

  GameWidget({Key key, @required this.game, @required this.fullscreen}) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MapPainter(),
      child: Center(
        child: Text("FOO"),
      ),
    );
  }
}