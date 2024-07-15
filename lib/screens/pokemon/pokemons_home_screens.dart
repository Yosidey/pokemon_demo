import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pokemon_demo/blocs/blocs.dart';
import 'package:pokemon_demo/libraries/components/card_title.dart';
import 'package:pokemon_demo/libraries/components/image_fade.dart';
import 'package:pokemon_demo/libraries/components/my_text.dart';
import 'package:pokemon_demo/libraries/utilities/display_info.dart';
import 'package:pokemon_demo/libraries/utilities/utilities_image.dart';
import 'package:pokemon_demo/models/image_color/image_color.dart';
import 'package:pokemon_demo/models/pokemon/pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_demo/screens/pokemon/pokemons.dart';

class PokemonsHomePage extends StatelessWidget {
  const PokemonsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonsBloc()..add(const PokemonsGetDataEvent(current: 0)),
      child: const PokemonsHomeScreen(),
    );
  }
}

class PokemonsHomeScreen extends StatefulWidget {
  const PokemonsHomeScreen({Key? key}) : super(key: key);

  @override
  State<PokemonsHomeScreen> createState() => _PokemonsHomeScreenState();
}

class _PokemonsHomeScreenState extends State<PokemonsHomeScreen> {
  final scrollController = ScrollController();
  final _textController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  final form = GlobalKey<FormState>();
  PokemonPage pokemonPage = PokemonPage.noData();
  bool isLoadingPokemons = true;
  bool isLoadingHistory = false;
  final utilImage = UtilitiesImage();
  late List<String> listHistory = [];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(getPokemonsPage);
    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(getPokemonsPage);
    scrollController.dispose();
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _focusListener() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
    if (isFocused) getListPokemons();
  }

  List<Pokemon> listPokemons() => pokemonPage.results;

  bool isValidGetPokemons() =>
      scrollController.position.pixels == scrollController.position.maxScrollExtent && listPokemons().length < pokemonPage.count && !isLoadingPokemons;

  void getPokemonsPage() {
    if (isValidGetPokemons()) {
      BlocProvider.of<PokemonsBloc>(context).add(PokemonsGetDataEvent(current: listPokemons().length));
    }
  }

  void getListPokemons() {
    BlocProvider.of<PokemonsBloc>(context).add(const PokemonsHistoryGetDataEvent());
  }

  void searchPokemon() {
    if (form.currentState!.validate()) {
      _focusNode.unfocus();
      BlocProvider.of<PokemonsBloc>(context).add(PokemonsPokemonSearchEvent(pokemon: _textController.text));
    }
  }

  void clearSearch() {
    _textController.clear();
    _focusNode.unfocus();
    pokemonPage = PokemonPage.noData();

    BlocProvider.of<PokemonsBloc>(context).add(PokemonsGetDataEvent(current: listPokemons().length));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokemonsBloc, PokemonsState>(
      listener: (context, state) {
        setState(() {
          if (state is PokemonsGetDataLoadingState) {
            isLoadingPokemons = true;
          }
          if (state is PokemonsGetDataReceivedState) {
            pokemonPage.count = state.pokemonPage.count;
            pokemonPage.next = state.pokemonPage.next;
            pokemonPage.previous = state.pokemonPage.previous;
            pokemonPage.results.addAll(state.pokemonPage.results);
          }
          if (state is PokemonsGetDataSuccessState) {
            isLoadingPokemons = false;
          }
          if (state is PokemonsPokemonSearchGetDataLoadingState) {
            isLoadingPokemons = true;
            pokemonPage = PokemonPage.noData();
          }
          if (state is PokemonsPokemonSearchGetDataReceivedState) {
            pokemonPage = state.pokemonPage;
          }
          if (state is PokemonsPokemonSearchGetDataLoadingState) {
            isLoadingPokemons = false;
          }
          if (state is PokemonsHistoryDataLoadingState) {
            isLoadingHistory = true;
          }
          if (state is PokemonsHistoryDataReceivedState) {
            listHistory = state.listSearch;
          }

          if (state is PokemonsHistoryDataSuccessState) {
            isLoadingHistory = false;
          }
          if (state is PokemonsFailureState) {
            isLoadingPokemons = false;
            isLoadingHistory = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        });
      },
      child: BlocBuilder<PokemonsBloc, PokemonsState>(
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LogoPokedex(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      IconButton( key: const Key('ButtonSearch'),icon: const Icon(Icons.search), onPressed: searchPokemon),
                      Expanded(
                        child: Form(
                          key: form,
                          child: TextFormField(
                            key: const Key('TextSearch'),
                            controller: _textController,
                            focusNode: _focusNode,
                            decoration: const InputDecoration(hintText: 'Search...', border: InputBorder.none),
                            validator: (value) {
                              if (value == null || value.isEmpty) return "Text empty";
                              return null;
                            },
                            onEditingComplete: searchPokemon,
                            textInputAction: TextInputAction.search,
                          ),
                        ),
                      ),
                      if (_textController.text.isNotEmpty) IconButton(key: const Key('ButtonClear'),icon: const Icon(Icons.clear), onPressed: clearSearch),
                    ],
                  ),
                ),
                if (isFocused && listHistory.isNotEmpty)
                  Container(
                    height: 64,
                    color: Colors.yellow,
                    padding: const EdgeInsets.all(8),
                    child: ListView.separated(
                      itemCount: listHistory.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ActionChip(
                        label: Text(listHistory[index]),
                        padding: const EdgeInsets.all(4),
                        onPressed: () {
                          _textController.text = listHistory[index];
                          searchPokemon();
                        },
                      ),
                      separatorBuilder: (context, index) => const Gap(8),
                    ),
                  ),
                MyText(text: "Pokemons:${listPokemons().length}", font: 16, bold: true),
                Expanded(
                  child: GridView.builder(
                    key: const Key("ListPokemon"),
                    controller: scrollController,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      mainAxisExtent: 300,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    shrinkWrap: false,
                    itemCount: listPokemons().length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        key:  Key("ListPokemon_$index"),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            builder: (context) => PokemonsDetailsPage(id: listPokemons()[index].id),
                          );
                        },
                        child: FutureBuilder<ImageColor>(
                          future: utilImage.generateImagePalette(listPokemons()[index].id, displayHeight(context) * 0.4),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.hasError) {
                              return CardTitle(
                                pokemon: listPokemons()[index],
                                image: const NotImage(),
                                primary: Colors.white,
                                secondary: Colors.grey,
                              );
                            }
                            final image = snapshot.data!.image;
                            final paletteGenerator = snapshot.data!.paletteGenerator;

                            return CardTitle(
                              pokemon: listPokemons()[index],
                              image: image,
                              primary: paletteGenerator.dominantColor!.color,
                              secondary: paletteGenerator.paletteColors[1].color,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Gap(8),
                if (isLoadingPokemons) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
