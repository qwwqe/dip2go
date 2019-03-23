import 'package:flutter/material.dart';
import 'dart:io';
import 'constants.dart';
import 'login.dart';

class GameListPage extends StatefulWidget {
  final Map<String, String> cookies;
  GameListPage({Key key, this.cookies}) : super(key: key);

  @override
  _GameListPageState createState() => _GameListPageState();

}

class _GameListPageState extends State<GameListPage> {
  List<Game> games;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games"),
      ),
      body: Text("Foo"),
    );
  }

  void _updateGameList() {
    var params = {

    };

    HttpClient client = HttpClient();
    client
        .postUrl(Uri.http(WEB_DIP_AUTHORITY,
        WEB_DIP_GAME_LISTING_PATH, params))
        .then((req) => req.close())
        .then((resp) {
      if (resp.statusCode != 200) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to load game list."),
          ),
        );
        return;
      } else if (!resp.cookies.any((cookie) => cookie.name == WEB_DIP_AUTH_COOKIE)) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(cookieSetter: widget.coo)), (v) => false);
      }
    });
  }
}

class Game {
  String title;
  String date;
  String phase;
  Duration timeRemaining;
  List<User> users;
  String gameId;
}

class User {
  String name;
  String country;
}