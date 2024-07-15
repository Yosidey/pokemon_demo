import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_demo/libraries/utilities/utilities_string.dart';
import 'package:pokemon_demo/models/pokemon/pokemon.dart';
import 'package:pokemon_demo/screens/pokemon/pokemons.dart';
import 'package:pokemon_demo/services/request/request_pokemon.dart';
import 'package:pokemon_demo/services/storage/storage_pokemon.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  /// Initial default state
  @override
  PokemonsBloc() : super(const PokemonsInitialState());

  PokemonsState get initialState => const PokemonsInitialState();

  ///*************** mapEventToState ***************
  @override
  Stream<PokemonsState> mapEventToState(PokemonsEvent event) async* {
    final requestPokemon = RequestPokemons();
    final storagePokemon = StoragePokemon();
    try {
      if (event is PokemonsGetDataEvent) {
        yield const PokemonsGetDataLoadingState();
        yield PokemonsGetDataReceivedState(pokemonPage: await requestPokemon.getPokemons(offset: event.current));
        yield const PokemonsGetDataSuccessState();
      }
      if (event is PokemonsPokemonIdGetDataEvent) {
        yield const PokemonsPokemonIdGetDataLoadingState();
        yield PokemonsPokemonIdGetDataReceivedState(pokemonDetails: await requestPokemon.getPokemonId(id: event.id));
        yield const PokemonsPokemonIdGetDataSuccessState();
      }

      if (event is PokemonsPokemonSearchEvent) {
        yield const PokemonsPokemonSearchGetDataLoadingState();

        yield PokemonsHistoryDataReceivedState(listSearch: await storagePokemon.addPokemon(text: event.pokemon));
        PokemonPage pokemonPage = await requestPokemon.getPokemonsAll();
        pokemonPage.results = UtilitiesString().searchAndSort(pokemonPage.results, event.pokemon);
        yield PokemonsPokemonSearchGetDataReceivedState(pokemonPage: pokemonPage);
        yield const PokemonsPokemonSearchGetDataSuccessState();
      }

      if (event is PokemonsHistoryGetDataEvent) {
        yield const PokemonsHistoryDataLoadingState();
        yield PokemonsHistoryDataReceivedState(listSearch: await storagePokemon.getPokemons());
        yield const PokemonsHistoryDataSuccessState();
      }
    } catch (error) {
      yield PokemonsFailureState(error: error.toString());
    }
  }
}
