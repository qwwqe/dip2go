import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'listgames.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  final Function cookieSetter;

  LoginPage({Key key, this.cookieSetter}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dip2Go"),
        ),
        body: Form(
            key: _formKey,

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please dip 2 go';
                        }
                      }),
                  TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'I told you to dip';
                        }
                      },
                      obscureText: true),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Builder(builder: (BuildContext innerContext) {
                        return RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Scaffold.of(innerContext).showSnackBar(
                                SnackBar(
                                  content: Text("Logging in..."),
                                ),
                              );
                              var username =
                                  _usernameController.text; // form: loginuser
                              var password =
                                  _passwordController.text; // form: loginpass
                              var params = {
                                'loginuser': username,
                                'loginpass': password,
                              };

                              HttpClient client = HttpClient();
                              client
                                  .postUrl(Uri.http(WEB_DIP_AUTHORITY,
                                  WEB_DIP_LOGON_PATH, params))
                                  .then((req) => req.close())
                                  .then((resp) {
                                if (resp.statusCode != 200 || !resp.cookies.any((cookie) => cookie.name == WEB_DIP_AUTH_COOKIE)) {
                                  Scaffold.of(innerContext).showSnackBar(
                                    SnackBar(
                                      content: Text("Failed to login."),
                                    ),
                                  );
                                  return;
                                }

                                widget.cookieSetter(resp.cookies);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => GameListPage()));
                              });
                            }
                          },
                          child: Text('Dip'),
                        );
                      }))
                ])));
  }

  Future<http.Response> fetchPost(String url, Map<String, String> body) async {
    final response = await http.post(url, body: body);
    return response;
  }
}