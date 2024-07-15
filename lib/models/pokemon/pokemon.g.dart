part of 'pokemon.dart';



Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
      id: UtilitiesString().getIdUrl(url: json['url'] as String),
      name: json['name'] as String,
      url: json['url'] as String,
    );



PokemonPage _$PokemonPageFromJson(Map<String, dynamic> json) => PokemonPage(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>).map((e) => Pokemon.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$PokemonPageToJson(PokemonPage instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };


