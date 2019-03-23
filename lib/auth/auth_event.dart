import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthEvent {
  final String key;

  LoggedIn({@required this.key}) : super([key]);

  @override
  String toString() => 'LoggedIn (Key: $key)';
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}