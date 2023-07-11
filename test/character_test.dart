import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars/widgets/character.dart';

void main() {
  testWidgets('Character widget displays the character name',
      (WidgetTester tester) async {
    const characterName = 'Luke Skywalker';

    await tester.pumpWidget(
      const MaterialApp(
        home: Character(characterName: characterName),
      ),
    );

    final textFinder = find.text(characterName);
    expect(textFinder, findsOneWidget);
  });
}
