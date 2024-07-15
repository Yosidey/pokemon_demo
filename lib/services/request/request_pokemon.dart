import 'package:pokemon_demo/models/pokemon/pokemon.dart';
import 'package:pokemon_demo/services/helpers/apibase_helper.dart';
import 'package:pokemon_demo/libraries/data/api_data.dart';
import 'package:pokemon_demo/services/helpers/exceptions.dart';

class RequestPokemons {
  /// Singleton constructor
  static final RequestPokemons _intance = RequestPokemons.internal();

  factory RequestPokemons() => _intance;

  RequestPokemons.internal();

  Future<PokemonPage> getPokemons({required int offset}) async {
    /// Open API Service
    /// ?offset=20&limit=20
    ApiService apiServer = ApiService(url: "$pokemon?offset=$offset&limit=20", request: "getPokemons()");
    var response = await apiServer.apiGetRequest();
    if (response == null) throw AppException("Sin resultados", "Aviso");
    return PokemonPage.fromJson(response);
  }

  Future<PokemonDetails> getPokemonId({required int id}) async {
    /// Open API Service
    /// ?offset=20&limit=20
    ApiService apiServer = ApiService(url: "$pokemon$id", request: "getPokemonId()");
    var response = await apiServer.apiGetRequest();
    if (response == null) throw AppException("Sin resultados", "Aviso");
    return PokemonDetails.fromJson(response);
  }

  Future<PokemonPage> getPokemonsAll() async {
    /// Open API Service
    /// ?offset=20&limit=20
    ApiService apiServer = ApiService(url: "$pokemon?offset=0&limit=1302", request: "getPokemonsAll()");
    var response = await apiServer.apiGetRequest();
    if (response == null) throw AppException("Sin resultados", "Aviso");
    return PokemonPage.fromJson(response);
  }
}
