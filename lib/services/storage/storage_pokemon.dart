import 'package:pokemon_demo/libraries/data/keys_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoragePokemon {
  Future<List<String>> addPokemon({required String text}) async {
    final storage = await SharedPreferences.getInstance();
    List<String> listPokemons = await getPokemons();
    if (!listPokemons.contains(text) && text.isNotEmpty) listPokemons.add(text);
    await storage.setStringList(keySearch, listPokemons);
    return listPokemons;
  }

  Future<List<String>> getPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(keySearch) ?? [];
  }
}
