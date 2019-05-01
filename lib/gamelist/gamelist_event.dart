import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GameListEvent extends Equatable {
  GameListEvent([List props = const []]) : super(props);
}

class GetGameList extends GameListEvent {
  @override
  String toString() => "GetGameList";
}