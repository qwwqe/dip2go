import 'package:meta/meta.dart';
import 'package:dip2go/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dip2go/model/model.dart';

class WebDipRepository {
  final WebDipProvider webDipProvider;

  WebDipRepository({@required this.webDipProvider}) : assert(webDipProvider != null);

  Future<String> authenticate({@required String username, @required String password}) async {
    return await webDipProvider.login(username: username, password: password);
  }

  Future<void> deauthenticate() async {
    // TODO: this is stupid
    var key = await getKey();
    webDipProvider.logout(key: key);
    await removeKey();
    return;
  }

  Future<List<WebDipGame>> getGameList({@required String key}) async {

  }

  Future<void> removeKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(webDipProvider.webDipAuthCookie);
    return;
  }

  Future<void> saveKey({@required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(webDipProvider.webDipAuthCookie, key);
    return;
  }

  Future<bool> hasKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().contains(webDipProvider.webDipAuthCookie);
  }

  Future<String> getKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(webDipProvider.webDipAuthCookie);
  }
}