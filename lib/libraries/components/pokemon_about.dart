

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pokemon_demo/libraries/components/linear_stat.dart';
import 'package:pokemon_demo/libraries/components/my_text.dart';
import 'package:pokemon_demo/libraries/utilities/display_info.dart';
import 'package:pokemon_demo/models/pokemon/pokemon.dart';

class PokemonAbout extends StatelessWidget {
  const PokemonAbout({super.key, required this.image, required this.pokemonDetails, required this.primary, required this.secondary});

  final Widget image;
  final PokemonDetails pokemonDetails;

  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: displayHeight(context) * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
                ),
              ),
              image,
              Container(margin: const EdgeInsets.all(8), height: 8, width: 64, color: Colors.grey),
            ],
          ),
          const Gap(16),
          if (pokemonDetails.forms.isNotEmpty) MyText(text: pokemonDetails.forms[0].name.toUpperCase()),
          const Gap(8),
          MyText(text: "#${pokemonDetails.id}".toUpperCase(), bold: true, font: 24),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleSub(title: "${pokemonDetails.height}", subTitle: "height"),
              const Gap(32),
              TitleSub(title: "${pokemonDetails.weight}", subTitle: "weight"),
            ],
          ),
          const Gap(8),
          if (pokemonDetails.types.isNotEmpty)
            Chip(label: MyText(text: pokemonDetails.types[0].type.name.toUpperCase(), color: Colors.white), backgroundColor: secondary),
          if (pokemonDetails.stats.isNotEmpty)
            const Padding(padding: EdgeInsets.all(8.0), child: Align(alignment: Alignment.centerLeft, child: MyText(text: "Stats", bold: true, font: 24))),
          Expanded(
            child: ListView.separated(
              itemCount: pokemonDetails.stats.length,
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  LinearStat(name: pokemonDetails.stats[index].stat.name, baseStat: pokemonDetails.stats[index].baseStat, secondary: secondary),
              separatorBuilder: (context, index) => const Gap(16),
            ),
          ),
        ],
      ),
    );
  }
}