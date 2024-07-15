import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pokemon_demo/blocs/blocs.dart';
import 'package:pokemon_demo/libraries/components/image_fade.dart';
import 'package:pokemon_demo/libraries/components/linear_stat.dart';
import 'package:pokemon_demo/libraries/components/my_text.dart';
import 'package:pokemon_demo/libraries/components/pokemon_about.dart';

import 'package:pokemon_demo/libraries/utilities/display_info.dart';
import 'package:pokemon_demo/libraries/utilities/utilities_image.dart';
import 'package:pokemon_demo/libraries/utilities/utilities_string.dart';
import 'package:pokemon_demo/models/image_color/image_color.dart';
import 'package:pokemon_demo/models/pokemon/pokemon.dart';
import 'package:pokemon_demo/screens/pokemon/pokemons.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonsDetailsPage extends StatelessWidget {
  const PokemonsDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonsBloc()..add(PokemonsPokemonIdGetDataEvent(id: id)),
      child: const PokemonsDetailsScreen(),
    );
  }
}

class PokemonsDetailsScreen extends StatefulWidget {
  const PokemonsDetailsScreen({super.key});

  @override
  State<PokemonsDetailsScreen> createState() => _PokemonsDetailsScreenState();
}

class _PokemonsDetailsScreenState extends State<PokemonsDetailsScreen> {
  late PokemonDetails pokemonDetails = PokemonDetails.noData();
  bool isLoading = false;
  final utilImage = UtilitiesImage();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokemonsBloc, PokemonsState>(
      listener: (context, state) {
        setState(() {
          if (state is PokemonsPokemonIdGetDataLoadingState) {
            isLoading = true;
          }
          if (state is PokemonsPokemonIdGetDataReceivedState) {
            pokemonDetails = state.pokemonDetails;
          }
          if (state is PokemonsPokemonIdGetDataSuccessState) {
            isLoading = false;
          }
          if (state is PokemonsFailureState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        });
      },
      child: BlocBuilder<PokemonsBloc, PokemonsState>(
        builder: (context, state) => Stack(
          children: [
            FutureBuilder<ImageColor>(
              future: utilImage.generateImagePalette(pokemonDetails.id,displayHeight(context) * 0.4),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return PokemonAbout(
                    image: const NotImage(),
                    pokemonDetails: pokemonDetails,
                    primary: Colors.grey,
                    secondary: Colors.grey,
                  );
                }
                final image = snapshot.data!.image;
                final paletteGenerator = snapshot.data!.paletteGenerator;
                return PokemonAbout(
                  image: image,
                  pokemonDetails: pokemonDetails,
                  primary: paletteGenerator.dominantColor!.color,
                  secondary: paletteGenerator.paletteColors[1].color,
                );
              },
            ),
            if (isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}


