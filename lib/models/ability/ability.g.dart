part of 'ability.dart';

AbilityDetail _$AbilityDetailFromJson(Map<String, dynamic> json) => AbilityDetail(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      ability: AbilityDetail.fromJson(json["ability"]),
      isHidden: json["is_hidden"],
      slot: json["slot"],
    );
