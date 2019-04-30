import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dip2go/gamelist/gamelist.dart';
import 'package:dip2go/auth/auth.dart';
import 'package:dip2go/repository/repository.dart';
import 'package:dip2go/provider/provider.dart';

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  final DipRepository dipRepository;
  final AuthBloc authBloc;

  GameListBloc({@required this.dipRepository, @required this.authBloc}) :
        assert(dipRepository != null),
        assert(authBloc != null);

  @override
  GameListState get initialState => GameListLoading();

  @override
  Stream<GameListState> mapEventToState(GameListState currentState, GameListEvent event) async* {
    if(event is GetGameList) {
      yield GameListLoading();

      try {
        // TODO: just make the token internal to DipRepository?
        final token = await dipRepository.getToken();
        final gameList = await dipRepository.getGameList(
            token: token, type: event.type);
        yield GameListLoaded(gameList: gameList);
      } on DipUnauthorizedException {
        // TODO: maybe display a toast or something
        authBloc.dispatch(LoggedOut());
      } catch (error) {
        yield GameListFailure(error: error.toString());
      }
    }
  }
}