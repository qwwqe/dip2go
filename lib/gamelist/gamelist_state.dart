import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:dip2go/model/model.dart';

abstract class GameListState extends Equatable {
  GameListState([List props = const []]) : super(props);
}

class GameListLoading extends GameListState {
  @override
  String toString() => "GameListLoading";
}

class GameListLoaded extends GameListState {
  final List<DipGame> gameList;

  GameListLoaded({@required this.gameList}) : assert(gameList != null), super([gameList]);

  @override
  String toString() => "GameListLoaded";
}

class GameListFailure extends GameListState {
  final String error;

  GameListFailure({@required this.error}) : super([error]);

  @override
  String toString() => "GameListFailure: ${this.error}";
}