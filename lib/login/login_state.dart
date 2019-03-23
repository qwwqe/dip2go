import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInit extends LoginState {
  @override
  String toString() => "LoginInit";
}

class LoginLoading extends LoginState {
  @override
  String toString() => "LoginLoading";
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => "LoginFailure: ${this.error}";
}