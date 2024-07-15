import 'package:json_annotation/json_annotation.dart';

import 'package:pokemon_demo/libraries/utilities/utilities_string.dart';
import 'package:pokemon_demo/models/ability/ability.dart';
import 'package:pokemon_demo/models/form/form.dart';
import 'package:pokemon_demo/models/stat/stat.dart';
import 'package:pokemon_demo/models/type/type.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  final int id;
  final String name;
  final String url;

  const Pokemon({required this.id, required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);

}

@JsonSerializable()
class PokemonPage {
  late int count;
  late String? next;
  late String? previous;
  late List<Pokemon> results;

  PokemonPage.noData() {
    count = 0;
    next = null;
    previous = null;
    results = [];
  }

  PokemonPage({required this.count, this.next, this.previous, required this.results});

  factory PokemonPage.fromJson(Map<String, dynamic> json) => _$PokemonPageFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonPageToJson(this);
}

@JsonSerializable()
class PokemonDetails {
  late List<Ability> abilities;
  late int baseExperience;
  late int height;
  late int id;
  late List<Form> forms;
  late List<Stat> stats;
  late List<Type> types;
  late int weight;

  PokemonDetails.noData() {
    abilities = [];
    baseExperience = 0;
    height = 0;
    id = 0;
    forms=[];
    stats = [];
    types = [];
    weight = 0;
  }

  PokemonDetails({
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.forms,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) => PokemonDetails(
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        forms: List<Form>.from(json["forms"].map((x) => Form.fromJson(x))),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
      );
}
