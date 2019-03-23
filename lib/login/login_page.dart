import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:dip2go/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final WebDipRepository webDipRepository;

  LoginPage({Key key, @required this.webDipRepository}) :
        assert(webDipRepository != null), super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthBloc _authBloc;

  WebDipRepository get _webDipRepository => widget.webDipRepository;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = LoginBloc(
      webDipRepository: _webDipRepository,
      authBloc: _authBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("dip2login"),
        ),
        body: LoginForm(
          authBloc: _authBloc,
          loginBloc: _loginBloc,
        )
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}