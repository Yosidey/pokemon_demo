import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_demo/libraries/components/image_fade.dart';
import 'package:pokemon_demo/libraries/utilities/display_info.dart';
import 'package:pokemon_demo/libraries/utilities/utilities_string.dart';
import 'package:pokemon_demo/models/image_color/image_color.dart';
import 'package:transparent_image/transparent_image.dart';

class UtilitiesImage {
  Future<ImageColor> generateImagePalette(int id, double height) async {
    //final image = Image.network(UtilitiesString().getUrlImage(id: id), fit: BoxFit.fill, width: double.infinity, height: double.infinity);
    final image = FadeInImage.memoryNetwork(
        image: UtilitiesString().getUrlImage(id: id),
        height: height,
        fit: BoxFit.fill,
        placeholder: kTransparentImage,
        imageErrorBuilder: (context, error, stackTrace) => const NotImage());
    final paletteGenerator = await PaletteGenerator.fromImageProvider(image.image);
    debugPrint("OK: $id");
    return ImageColor(image: image, paletteGenerator: paletteGenerator);
  }
}
