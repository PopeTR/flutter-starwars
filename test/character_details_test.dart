import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/screens/character_details.dart';

void main() {
  testWidgets('Character Details page displays Character name', (tester) async {
    final Character character = Character.fromJson({
      'name': 'C-3PO',
      'species': {'classification': 'artificial'},
      'starshipConnection': {'starships': []},
      'homeworld': {'name': 'Tatooine'},
    });

    await tester.pumpWidget(
      MaterialApp(home: CharacterDetailsScreen(character: character)),
    );
    final textFinder = find.text(character.name);
    expect(textFinder, findsOneWidget);
  });
}
