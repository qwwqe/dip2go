import 'package:meta/meta.dart';
import 'package:dip2go/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dip2go/model/model.dart';

class DipRepository {
  static const String AUTH_TOKEN = "authToken";
  final DipProvider dipProvider;

  DipRepository({@required this.dipProvider}) : assert(dipProvider != null);

  Future<String> authenticate({@required String username, @required String password}) async {
    return await dipProvider.login(username: username, password: password);
  }

  Future<void> deauthenticate() async {
    // TODO: this is stupid. maybe save the token as a field. could we make sure that's always up-to-date?
    var token = await getToken();
    dipProvider.logout(token: token);
    await removeToken();
    return;
  }

  Future<List<DipGame>> getGameList({@required String token, @required String type}) async {
    var token = await getToken();
    return await dipProvider.getGameList(token: token, type: type);
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AUTH_TOKEN);
    return;
  }

  Future<void> saveToken({@required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AUTH_TOKEN, token);
    return;
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().contains(AUTH_TOKEN);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(AUTH_TOKEN);
  }


}