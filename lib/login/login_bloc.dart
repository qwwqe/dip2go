import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dip2go/login/login.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:dip2go/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DipRepository dipRepository;
  final AuthBloc authBloc;

  LoginBloc({@required this.dipRepository, @required this.authBloc}) :
      assert(dipRepository != null),
      assert(authBloc != null);

  @override
  LoginState get initialState => LoginInit();

  @override
  Stream<LoginState> mapEventToState(LoginState currentState, LoginEvent event) async* {
    if(event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        print("FOO");
        final token = await dipRepository.authenticate(username: event.username, password: event.password);
        print("BAR");
        authBloc.dispatch(LoggedIn(token: token));
        yield LoginInit();
      } catch (error) {
        print("ZAP");
        yield LoginFailure(error: error.toString());
      }
    }
  }
}