import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GameListEvent extends Equatable {
  GameListEvent([List props = const []]) : super(props);
}

class GetGameList extends GameListEvent {
  final String type;

  GetGameList({@required this.type}) : assert(type != null), super([type]);

  @override
  String toString() => "GetGameList ($type)";
}