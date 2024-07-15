import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_demo/libraries/data/app_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_demo/bloc_delegates.dart';
import 'package:pokemon_demo/screens/pokemon/pokemons_home_screens.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  debugPrint("kReleaseMode:$kReleaseMode");
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
    ErrorWidget.builder = (FlutterErrorDetails details) => const Scaffold(body: Text("Error desconocido"));
    runApp(const MyApp());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titleApp,
      debugShowCheckedModeBanner: kDebugMode,
      theme: ThemeData(useMaterial3: false),
      home: const PokemonsHomePage(),
    );
  }
}
