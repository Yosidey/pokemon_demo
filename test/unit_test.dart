import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_demo/libraries/utilities/utilities_string.dart';
import 'package:pokemon_demo/models/pokemon/pokemon.dart';
import 'package:pokemon_demo/services/request/request_pokemon.dart';

void main() {
  test('Get ID from a URL', () async {
    final requestPokemon = RequestPokemons();
    expect(UtilitiesString().getIdUrl(url: "https://pokeapi.co/api/v2/pokemon/21/"), 21);
    expect(UtilitiesString().getIdUrl(url: "https://pokeapi.co/api/v2/pokemon/21/"), isA<int>());
    expect(await requestPokemon.getPokemons(offset: 1), isA<PokemonPage>());
    expect(await requestPokemon.getPokemonId(id: 1), isA<PokemonDetails>());
  });
}
