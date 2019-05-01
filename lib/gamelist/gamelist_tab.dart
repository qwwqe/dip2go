import 'package:flutter/material.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dip2go/common/common.dart';
import 'package:dip2go/model/model.dart';
import 'gamelist.dart';

class GameListTab extends StatefulWidget {
  final DipRepository dipRepository;
  final List<DipGame> games;

  GameListTab({@required this.dipRepository, @required this.games}) :
        assert(dipRepository != null),
        assert(games != null);

  @override
  _GameListTab createState() => _GameListTab();
}

class _GameListTab extends State<GameListTab> {
  GameListBloc _gameListBloc;
  AuthBloc _authBloc;

  DipRepository get _dipRepository => widget.dipRepository;
  List<DipGame> get _games => widget.games;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _gameListBloc = BlocProvider.of<GameListBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext build) => BlocBuilder<GameListEvent, GameListState>(
    bloc: _gameListBloc,
    builder: (BuildContext context, GameListState state) {
      if (state is GameListLoading) {
        return LoadingIndicator();
      }

      if (state is GameListLoaded) {
        if (_games.isEmpty) {
          return Center(
            child: Text("No games."),
          );
        }
        return ListView.builder(
          itemCount: _games.length,
          itemBuilder: (BuildContext context, int index) => Card(
                child: ListTile(
                  title: Text(_games[index].title),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  subtitle: Text(_games[index].phase)
                ),
          ),
        );
      }

      if (state is GameListFailure) {
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Failed to load game list.")));
        return Center(
          child: Icon(Icons.error),
        );
      }
    },
  );
}