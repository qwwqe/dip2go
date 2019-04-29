import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dip2go/common/common.dart';
import 'package:dip2go/gamelist/gamelist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dip2go/splash/splash.dart';
import 'package:bloc/bloc.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/login/login.dart';
import 'package:dip2go/provider/provider.dart';

class PrintTransitionDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    debugPrint(transition.toString());
  }
}

void main() {
  BlocSupervisor().delegate = PrintTransitionDelegate();
  runApp(MainApp(
      dipRepository:
        DipRepository(dipProvider: DipProvider(httpClient: http.Client()))
  ));
}

class MainApp extends StatefulWidget {
  final DipRepository dipRepository;

  MainApp({Key key, @required this.dipRepository}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  AuthBloc authBloc;

  DipRepository get dipRepository => widget.dipRepository;

  @override
  void initState() {
    authBloc = AuthBloc(dipRepository: dipRepository);
    authBloc.dispatch(AppStarted());
  }

  @override
  dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      bloc: authBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthEvent, AuthState>(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            if (state is AuthUninitialized) {
              return SplashPage();
            }

            if (state is AuthAuthenticated) {
              return GameListPage(dipRepository: dipRepository);
            }

            if (state is AuthUnauthenticated) {
              return LoginPage(dipRepository: dipRepository);
            }

            if (state is AuthLoading) {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
