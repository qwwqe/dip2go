import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:dip2go/common/common.dart';
import 'package:dip2go/auth/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Map<String, String> cookies;

  @override
  void initState() {
    super.initState();
/*
    cookies = Map();
    if (cookies.containsKey(WEB_DIP_AUTH_COOKIE)) {
      // TODO: confirm login
      //Navigator.of(context).pushReplacementNamed("gameList");
    }
*/
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text("Dip 2 Go")
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              GameList(),
              RaisedButton(
                  child: Text("Quit Dippin'"),
                  onPressed: () => authBloc.dispatch(LoggedOut()),
              ),
            ]
        ),
      ),
    );
  }
}