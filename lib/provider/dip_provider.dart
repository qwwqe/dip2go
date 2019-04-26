import 'dart:async';
import 'package:dip2go/model/model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

class DipProvider {
  static const String DIP_AUTHORITY = "http://192.168.0.108:9696";
  static const String DIP_LOGON_API = "/logon";
  static const String DIP_LOGOUT_API = "/logon";
  static const String DIP_COMMAND_API = "/command";

  final http.Client httpClient;

  DipProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<String> login({@required String username, @required String password}) async {
    var payload = {
      "action": "logon",
      "data": {
        "user": username,
        "pass": password,
      },
    };
    var resp = await httpClient.post(DIP_AUTHORITY + DIP_LOGON_API, body: jsonEncode(payload));

    if (resp.statusCode != 200) {
      throw("Error while attempting login (${resp.statusCode}).");
    }

    var data = jsonDecode(resp.body);
    if (data['success'] != 'ok') {
      throw("Error while attempting login (${data['error']})");
    }

    return data['token'];
    /*
    req.headers.set('content-type', 'application/json');
    req.add(utf8.encode(json.encode(params)));
    var resp = await req.close();
    if (resp.statusCode != 200) {
      resp.drain();
      throw("Error while attempting login (${resp.statusCode}).");
    }

    Map<String, dynamic> data;
    var completer = new Completer();
    resp.transform(utf8.decoder).listen((contents) {
      data = jsonDecode(contents);
    }, onDone: () {
      if (data['success'] != "ok") {
        throw("Error while attempting login (${data['error']}).");
      }
      completer.complete(data['token']);
    });

    return completer.future;
    */
  }

  Future<void> logout({@required String token}) async {
    var payload = {
      "action": "logout",
      "token": token,
    };
    var resp = await httpClient.post(DIP_AUTHORITY + DIP_LOGOUT_API, body: jsonEncode(payload));
    if (resp.statusCode != 200) {
      throw("Error while attempting logout (${resp.statusCode}).");
    }

    var data = jsonDecode(resp.body);
    if (data['success'] != 'ok') {
      throw("Error while attempting logout (${data['error']})");
    }

    /*
    var resp = await req.close();
    if (resp.statusCode != 200) {
      resp.drain();
      throw("Error while attempting logout (${resp.statusCode}).");
    }

    await resp.drain();
    return;
    */
  }

  Future<List<DipGame>> getGameList({@required String token}) async {

  }
}