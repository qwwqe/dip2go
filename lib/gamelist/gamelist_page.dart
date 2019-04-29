import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:dip2go/common/common.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/gamelist/gamelist.dart';

class GameListPage extends StatefulWidget {
  final DipRepository dipRepository;

  GameListPage({Key key, @required this.dipRepository}) : assert(dipRepository != null), super(key: key);

  @override
  _GameListPage createState() => _GameListPage();
}

class _GameListPage extends State<GameListPage> {

  DipRepository get dipRepository => widget.dipRepository;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => authBloc.dispatch(LoggedOut()),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Text("Active Games"),
              Text("Old Games"),
              Text("All Games"),
            ],
          ),
          title: Text("Dippin' Doodle"),
        ),
        body: TabBarView(
          children: [
            GameListTab(dipRepository: dipRepository, type: "active"),
            GameListTab(dipRepository: dipRepository, type: "old"),
            GameListTab(dipRepository: dipRepository, type: "all"),
            /*
            RaisedButton(
              child: Text("Quit Dippin'"),
              onPressed: () => authBloc.dispatch(LoggedOut()),
            ),
            */
          ],
        ),
      ),
    );
  }
}