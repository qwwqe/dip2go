import 'dart:async';
import 'package:dip2go/model/model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class WebDipProvider {
  static const String WEB_DIP_AUTHORITY = "www.webdiplomacy.net";
  static const String WEB_DIP_LOGON_PATH = "/index.php";
  static const String WEB_DIP_LOGOUT_PATH = "/logon.php";
  static const String WEB_DIP_GAME_LISTING_PATH = "/gamelistings.php";
  static const String WEB_DIP_AUTH_COOKIE = "wD-Key";

  final HttpClient httpClient;

  WebDipProvider({@required this.httpClient}) : assert(httpClient != null);

  String get webDipAuthCookie => WEB_DIP_AUTH_COOKIE;

  Future<String> login({@required String username, @required String password}) async {
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

    if (!resp.cookies.any((cookie) => cookie.name == webDipAuthCookie)) {
      resp.drain();
      throw("Login unsuccessful (credentials invalid?).");
    }

    String key = resp.cookies
        .firstWhere((cookie) => cookie.name == webDipAuthCookie)
        .value;
    await resp.drain();

    return key;
  }

  Future<void> logout({@required String key}) async {
    var req = await httpClient.getUrl(
        Uri.http(WEB_DIP_AUTHORITY, WEB_DIP_LOGOUT_PATH, {"logoff" : "on"}));
    req.cookies.add(Cookie(webDipAuthCookie, key));
    var resp = await req.close();
    if (resp.statusCode != 200) {
      resp.drain();
      throw("Error while attempting logout (${resp.statusCode}).");
    }

    await resp.drain();
    return;
  }

  Future<List<WebDipGame>> getGameList({@required String key}) async {

  }
}