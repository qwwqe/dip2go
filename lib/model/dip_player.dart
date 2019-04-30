import 'package:dip2go/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dip_player.g.dart';

@JsonSerializable()

class DipPlayer {
  DipPlayer();

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'country')
  String country;

  factory DipPlayer.fromJson(Map<String, dynamic> json) => _$DipPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$DipPlayerToJson(this);
}
