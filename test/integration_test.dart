// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:pokemon_demo/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Details Pokemon', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final Finder buttonSearch = find.byKey(const Key('ButtonSearch'));
    final Finder textSearch = find.byKey(const Key('TextSearch'));
    final Finder buttonClear = find.byKey(const Key('ButtonClear'));
    await Future.delayed(const Duration(seconds: 10));
    await tester.enterText(textSearch, "per");

    await Future.delayed(const Duration(seconds: 4));

    await tester.tap(buttonClear);
    await tester.pumpAndSettle();
    final listPokemonFinder = find.byKey(const Key("ListPokemon")); // Encuentra el ListView
    final listPokemon1 = find.byKey(const Key('ListPokemon_1'));

    expect(listPokemonFinder, findsOneWidget);
    expect(listPokemon1, findsOneWidget);

    await tester.tap(listPokemon1);
  });
}
