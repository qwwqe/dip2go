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
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn (Key: $token)';
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}