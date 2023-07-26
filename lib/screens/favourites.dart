import 'package:flutter/material.dart';

import '../models/character.dart';
import '../widgets/character_list_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Character> characters;
  const FavouritesScreen({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: characters.length,
              itemBuilder: (c, index) {
                return CharacterListItem(character: characters[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
