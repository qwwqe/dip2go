import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/auth/auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final WebDipRepository webDipRepository;

  AuthBloc({@required this.webDipRepository}) : assert(webDipRepository != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthState currentState, AuthEvent event) async* {
    if (event is AppStarted) {
      bool hasKey = await webDipRepository.hasKey();

      if (hasKey) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      await webDipRepository.saveKey(event.key);
      yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await webDipRepository.removeKey();
      yield AuthUnauthenticated();
    }
  }
}
