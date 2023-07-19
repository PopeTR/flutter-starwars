import 'package:flutter/material.dart';

import '../models/character.dart';
import '../screens/details.dart';

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({required this.character, super.key});
  final Character character;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DetailsScreen(
              character: character,
              isCharacterPage: true,
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(character.name),
        subtitle: Text(character.homeworld!.name),
      ),
    );
  }
}
