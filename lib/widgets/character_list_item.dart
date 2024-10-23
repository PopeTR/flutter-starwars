import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character.dart';
import '../providers/favourites_data.dart';
import '../screens/details.dart';

class CharacterListItem extends ConsumerWidget {
  const CharacterListItem({required this.character, super.key});
  final Character character;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouritesProvider);
    final isFavourite =
        favourites.any((favCharacter) => favCharacter.id == character.id);

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
        minVerticalPadding: 0,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        subtitle: Text(character.homeworld!.name),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        trailing: IconButton(
          onPressed: () {
            ref
                .read(favouritesProvider.notifier)
                .toggleFavouriteCharacter(character);
          },
          icon: isFavourite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
        ),
      ),
    );
  }
}
