import 'package:dip2go/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dip_game.g.dart';

@JsonSerializable()

class DipGame {
  DipGame();

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'phase')
  String phase;

  @JsonKey(name: 'time_remaining')
  String timeRemaining;

  @JsonKey(name: 'players')
  List<DipPlayer> players;

  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'variant_id')
  String variantId;

  @JsonKey(name: 'variant_name')
  String variantName;

  @JsonKey(name: 'state')
  String state;

  factory DipGame.fromJson(Map<String, dynamic> json) => _$DipGameFromJson(json);

  Map<String, dynamic> toJson() => _$DipGameToJson(this);
}