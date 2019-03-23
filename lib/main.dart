import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'listgames.dart';
import 'constants.dart';
import 'login.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Dip2Go';

    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => HomePage(),
    });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> cookies;

  @override
  void initState() {
    super.initState();
    cookies = Map();
    if (cookies.containsKey(WEB_DIP_AUTH_COOKIE)) {
      // TODO: confirm login
      //Navigator.of(context).pushReplacementNamed("gameList");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cookies.length == 0) {
      return LoginPage(cookieSetter: _cookieSetter);
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  void _cookieSetter(List<Cookie> c) {
    setState(() {
      c.forEach((cookie) => cookies[cookie.name] = cookie.value);
    });
  }
}