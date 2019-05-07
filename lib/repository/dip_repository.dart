import 'package:meta/meta.dart';
import 'package:dip2go/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dip2go/model/model.dart';

class DipRepository {
  static const String AUTH_TOKEN_KEY = "authToken";
  String authToken;
  final DipProvider dipProvider;

  DipRepository({@required this.dipProvider}) : assert(dipProvider != null);

  Future<String> getToken() async {
    if (authToken != null) {
      return authToken;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _authToken = prefs.get(AUTH_TOKEN_KEY);
    if (_authToken != null) {
      authToken = _authToken;
    }
    return authToken;
  }

  Future<String> saveToken({@required String token}) async {
    authToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AUTH_TOKEN_KEY, token);
    return authToken;
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AUTH_TOKEN_KEY);
    authToken = null;
    return;
  }


  Future<String> authenticate({@required String username, @required String password}) async {
    String _authToken = await dipProvider.login(username: username, password: password);
    return await saveToken(token: _authToken);
  }

  Future<void> deauthenticate() async {
    var token = await getToken();
    dipProvider.logout(token: token);
    await removeToken();
    return;
  }

  Future<List<DipGame>> getGameList({@required String token}) async {
    var token = await getToken();
    return await dipProvider.getGameList(token: token);
  }

  Future<bool> hasToken() async {
    return getToken() != null;
  }

}