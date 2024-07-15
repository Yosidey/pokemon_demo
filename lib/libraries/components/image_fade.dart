import 'package:flutter/material.dart';
import 'package:pokemon_demo/libraries/data/app_data.dart';
import 'package:pokemon_demo/libraries/utilities/display_info.dart';
import 'package:transparent_image/transparent_image.dart';

class FadeImageMemoryNetwork extends StatelessWidget {
  const FadeImageMemoryNetwork({super.key, this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return (url!.isNotEmpty || url != null)
        ? FadeInImage.memoryNetwork(
            image: url!, fit: BoxFit.fill, placeholder: kTransparentImage, imageErrorBuilder: (context, error, stackTrace) => const NotImage())
        : const NotImage();
  }
}

class NotImage extends StatelessWidget {
  const NotImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(noFound, fit: BoxFit.contain);
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(appLogo, fit: BoxFit.contain);
  }
}

class LogoPokedex extends StatelessWidget {
  const LogoPokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(logoPokedex, fit: BoxFit.contain, height: displayHeight(context) * 0.2);
  }
}

class LogoPokedexPokemon extends StatelessWidget {
  const LogoPokedexPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(logoPokedexPokemom, fit: BoxFit.contain, height: 65, width: 65);
  }
}
