import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dip2go/login/login.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:dip2go/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final WebDipRepository webDipRepository;
  final AuthBloc authBloc;

  LoginBloc({@required this.webDipRepository, @required this.authBloc}) :
      assert(webDipRepository != null),
      assert(authBloc != null);

  @override
  LoginState get initialState => LoginInit();

  @override
  Stream<LoginState> mapEventToState(LoginState currentState, LoginEvent event) async* {
    if(event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final key = await webDipRepository.authenticate(username: event.username, password: event.password);
        authBloc.dispatch(LoggedIn(key: key));
        yield LoginInit();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}