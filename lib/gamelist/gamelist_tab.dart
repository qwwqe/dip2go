import 'package:flutter/material.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dip2go/common/common.dart';
import 'gamelist.dart';

class GameListTab extends StatefulWidget {
  final DipRepository dipRepository;
  final String type;

  GameListTab({@required this.dipRepository, @required this.type}) :
        assert(dipRepository != null),
        assert(type != null);

  @override
  _GameListTab createState() => _GameListTab();
}

class _GameListTab extends State<GameListTab> {
  GameListBloc _gameListBloc;
  AuthBloc _authBloc;

  DipRepository get _dipRepository => widget.dipRepository;
  String get _type => widget.type;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _gameListBloc = GameListBloc(dipRepository: _dipRepository, authBloc: _authBloc);
    _gameListBloc.dispatch(GetGameList(type: _type));
    super.initState();
  }

  @override
  void dispose() {
    _gameListBloc.dispose();
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
        if (state.gameList.isEmpty) {
          return Center(
            child: Text("No $_type games."),
          );
        }
        return ListView.builder(
          itemCount: state.gameList.length,
          itemBuilder: (BuildContext context, int index) => Card(
                child: ListTile(
                  title: Text(state.gameList[index].title),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  subtitle: Text(state.gameList[index].phase)
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