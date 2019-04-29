import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/auth/auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DipRepository dipRepository;

  AuthBloc({@required this.dipRepository}) : assert(dipRepository != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthState currentState, AuthEvent event) async* {
    if (event is AppStarted) {
      bool hasKey = await dipRepository.hasToken();

      if (hasKey) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      await dipRepository.saveToken(token: event.token);
      yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      // TODO: find a place for this (or don't separate auth and token removal)
      try {
        await dipRepository.deauthenticate();
      } catch (e) {
        print("Error on deauthentication: ${e.toString()}");
      }
      await dipRepository.removeToken();
      yield AuthUnauthenticated();
    }
  }
}
