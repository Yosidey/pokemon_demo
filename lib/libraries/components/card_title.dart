import 'package:flutter/material.dart';
import 'package:pokemon_demo/models/pokemon/pokemon.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({super.key, required this.pokemon, required this.image, required this.primary, required this.secondary});

  final Pokemon pokemon;
  final Widget image;
  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary.withOpacity(0.4),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: image),
            Text(pokemon.name.toUpperCase(), style: TextStyle(color: primary, fontSize: 16)),
            Text("#${pokemon.id}", style: TextStyle(color: secondary, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
