import 'package:flutter/material.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dip2go/common/common.dart';
import 'package:dip2go/model/model.dart';
import 'gamelist.dart';

class GameList extends StatelessWidget {
  final List<DipGame> games;
  GameList({@required this.games}) : assert(games != null);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) => Card(
            child: ListTile(
                title: Text(games[index].title),
                trailing: Icon(Icons.keyboard_arrow_right),
                subtitle: Text(games[index].phase)),
          ));
}
