import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class WebDipProvider {
  static const String WEB_DIP_AUTHORITY = "www.webdiplomacy.net";
  static const String WEB_DIP_LOGON_PATH = "/index.php";
  static const String WEB_DIP_GAME_LISTING_PATH = "/gamelistings.php";
  static const String WEB_DIP_AUTH_COOKIE = "wD-Key";

  final HttpClient httpClient;

  WebDipProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<String> login(String username, String password) async {
    var params = {
      "loginuser": username,
      "loginpass": password,
    };
    var req = await httpClient.postUrl(
        Uri.http(WEB_DIP_AUTHORITY, WEB_DIP_LOGON_PATH, params));
    var resp = await req.close();
    if (resp.statusCode != 200) {
      resp.drain();
      throw("Error while attempting login (${resp.statusCode}).");
    }

    if (!resp.cookies.any((cookie) => cookie.name == WEB_DIP_AUTH_COOKIE)) {
      resp.drain();
      throw("Login unsuccessful (credentials invalid?).");
    }

    String key = resp.cookies
        .firstWhere((cookie) => cookie.name == WEB_DIP_AUTH_COOKIE)
        .value;
    await resp.drain();

    return key;
  }
}