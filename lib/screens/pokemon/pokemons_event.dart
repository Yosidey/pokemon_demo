import 'package:equatable/equatable.dart';

abstract class PokemonsEvent extends Equatable {
  const PokemonsEvent();

  @override
  List<Object> get props => [];
}

class PokemonsGetDataEvent extends PokemonsEvent {
  const PokemonsGetDataEvent({required this.current, this.offsetNext, this.limitedNext, this.offsetPreview, this.limitedPreview});

  final int current;
  final int? offsetNext;
  final int? limitedNext;
  final int? offsetPreview;
  final int? limitedPreview;
}

class PokemonsPokemonIdGetDataEvent extends PokemonsEvent {
  const PokemonsPokemonIdGetDataEvent({required this.id});

  final int id;
}

class PokemonsHistoryGetDataEvent extends PokemonsEvent {
  const PokemonsHistoryGetDataEvent();
}

class PokemonsPokemonSearchEvent extends PokemonsEvent {
  const PokemonsPokemonSearchEvent({required this.pokemon});

  final String pokemon;
}
