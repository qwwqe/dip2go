import 'dart:async';
import 'package:dip2go/model/model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DipUnauthorizedException implements Exception {
  String message;
  DipUnauthorizedException(this.message);
}

class DipProvider {
  static const String DIP_AUTHORITY = "http://192.168.0.108:9696";
  static const String DIP_LOGON_API = "/logon";
  static const String DIP_LOGOUT_API = "/logon";
  static const String DIP_COMMAND_API = "/command";
  static const String DIP_GAME_API = "/game";

  static const int DIP_API_UNAUTH_ERR = 2;

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
      throw("Error while attempting login (${data['error']['message']})");
    }

    return data['data']['token'];
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
      throw("Error while attempting logout (${data['error']['message']}).");
    }
  }

  Future<List<DipGame>> getGameList({@required String token}) async {
    var payload = {
      "action": "list",
      "token": token,
    };
    var resp = await httpClient.post(DIP_AUTHORITY + DIP_GAME_API, body: jsonEncode(payload));
    if (resp.statusCode != 200) {
      throw("Error while requesting game list (${resp.statusCode}).");
    }

    var data = jsonDecode(resp.body);
    if (data['success'] != 'ok') {
      print(data['error']['code']);
      if (data['error']['code'] == DIP_API_UNAUTH_ERR) {
        throw DipUnauthorizedException(data['error']['message']);
      } else {
        throw("Error while requesting game list (${data['error']['message']}).");
      }
    }

    List<DipGame> games = [];
    print(data['data']['games']);
    for(int i = 0; i < data['data']['games'].length; i++) {
      games.add(new DipGame.fromJson(data['data']['games'][i]));
    }

    return games;
  }
}