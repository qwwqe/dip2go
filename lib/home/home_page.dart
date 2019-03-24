import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:dip2go/common/common.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:dip2go/repository/repository.dart';

class HomePage extends StatefulWidget {
  //final WebDipRepository webDipRepository; // TODO: unused

  //HomePage({Key key, @required this.webDipRepository}) : assert(webDipRepository != null), super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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