import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_demo/models/stat/stat.dart';

part 'ability.g.dart';

class AbilityDetail {
  String name;
  String url;

  AbilityDetail({
    required this.name,
    required this.url,
  });

  factory AbilityDetail.fromJson(Map<String, dynamic> json) => _$AbilityDetailFromJson(json);
}

class Ability {
  bool isHidden;
  int slot;
  AbilityDetail ability;

  Ability({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);
}
