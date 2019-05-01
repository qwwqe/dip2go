import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:dip2go/common/common.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/gamelist/gamelist.dart';
import 'package:dip2go/model/model.dart';

class GameListPage extends StatefulWidget {
  final DipRepository dipRepository;

  GameListPage({Key key, @required this.dipRepository}) : assert(dipRepository != null), super(key: key);

  @override
  _GameListPage createState() => _GameListPage();
}

class _GameListPage extends State<GameListPage> {
  AuthBloc _authBloc;
  GameListBloc _gameListBloc;
  List<DipGame> _games;

  DipRepository get _dipRepository => widget.dipRepository;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _gameListBloc = GameListBloc(dipRepository: _dipRepository, authBloc: _authBloc);
    _gameListBloc.dispatch(GetGameList());
    super.initState();
  }

  @override
  void dispose() {
    _gameListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => _authBloc.dispatch(LoggedOut()),
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
        body: BlocBuilder<GameListEvent, GameListState>(
          bloc: _gameListBloc,
          builder: (BuildContext context, GameListState state) {
            if (state is GameListLoading) {
              return LoadingIndicator();
            }

            if (state is GameListLoaded) {
              _games = state.gameList;
              return TabBarView(
                children: [
                  GameList(games: _games.where((g) => g.state == "active").toList()),
                  GameList(games: _games.where((g) => g.state == "old").toList()),
                  GameList(games: _games),
                ],
              );
            }

            if (state is GameListFailure) {
              //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Failed to load game list.")));
              return Center(
                child: Icon(Icons.error),
              );
            }
          },
        ),
      ),
    );
  }
}