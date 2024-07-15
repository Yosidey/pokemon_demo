import 'package:equatable/equatable.dart';
import 'package:pokemon_demo/models/pokemon/pokemon.dart';

abstract class PokemonsState extends Equatable {
  const PokemonsState();

  @override
  List<Object> get props => [];
}

class PokemonsInitialState extends PokemonsState {
  const PokemonsInitialState();
}

class PokemonsGetDataLoadingState extends PokemonsState {
  const PokemonsGetDataLoadingState();
}

class PokemonsGetDataReceivedState extends PokemonsState {
  const PokemonsGetDataReceivedState({required this.pokemonPage});

  final PokemonPage pokemonPage;
}

class PokemonsGetDataSuccessState extends PokemonsState {
  const PokemonsGetDataSuccessState();
}

class PokemonsPokemonSearchGetDataLoadingState extends PokemonsState {
  const PokemonsPokemonSearchGetDataLoadingState();
}

class PokemonsPokemonSearchGetDataReceivedState extends PokemonsState {
  const PokemonsPokemonSearchGetDataReceivedState({required this.pokemonPage});

  final PokemonPage pokemonPage;
}

class PokemonsPokemonSearchGetDataSuccessState extends PokemonsState {
  const PokemonsPokemonSearchGetDataSuccessState();
}

class PokemonsPokemonIdGetDataLoadingState extends PokemonsState {
  const PokemonsPokemonIdGetDataLoadingState();
}

class PokemonsPokemonIdGetDataReceivedState extends PokemonsState {
  const PokemonsPokemonIdGetDataReceivedState({required this.pokemonDetails});

  final PokemonDetails pokemonDetails;
}

class PokemonsPokemonIdGetDataSuccessState extends PokemonsState {
  const PokemonsPokemonIdGetDataSuccessState();
}

class PokemonsHistoryDataLoadingState extends PokemonsState {
  const PokemonsHistoryDataLoadingState();
}

class PokemonsHistoryDataReceivedState extends PokemonsState {
  const PokemonsHistoryDataReceivedState({required this.listSearch});

  final List<String> listSearch;
}

class PokemonsHistoryDataSuccessState extends PokemonsState {
  const PokemonsHistoryDataSuccessState();
}

class PokemonsFailureState extends PokemonsState {
  final String error;

  const PokemonsFailureState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "PokemonsFailureState{ error: $error}";
}
