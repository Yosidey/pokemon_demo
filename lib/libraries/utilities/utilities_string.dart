import 'package:pokemon_demo/models/pokemon/pokemon.dart';

class UtilitiesString {
  int getIdUrl({required String url}) {
    return int.parse(url.split('/')[6].split('.').first);
  }

  String getUrlImage({required int id}) {
    ///Fast and low quality. Small
    //return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";
    ///Slow and high quality. Big
    //return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/$id.png";
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  List<Pokemon> searchAndSort(List<Pokemon> list, String searchText) {
    searchText = searchText.toLowerCase();

    List<Pokemon> filteredList = list.where((item) => item.name.toLowerCase().startsWith(searchText)).toList();
    //filteredList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return filteredList;
  }
}
