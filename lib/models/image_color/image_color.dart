import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ImageColor {
  ImageColor({required this.image, required this.paletteGenerator});

  final Widget image;
  final PaletteGenerator paletteGenerator;
}