import 'package:meta/meta.dart';
import 'package:dip2go/provider/provider.dart';

class WebDipRepository {
  final WebDipProvider webDipProvider;

  WebDipRepository({@required this.webDipProvider}) : assert(webDipProvider != null);

  Future<String> authenticate({@required String username, @required String password}) async {
    return await webDipProvider.login(username, password);
  }

  Future<void> removeKey() async {
    // TODO: remove from keystore

    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> saveKey(String key) async {
    // TODO: save to keystore

    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasKey() async {
    // TODO: implement

    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}