import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character.dart';

class FavouritesNotifier extends StateNotifier<List<Character>> {
  FavouritesNotifier() : super([]);

  void toggleFavouriteCharacter(Character character) {
    final characterIsFavourite = state.contains(character);
    if (characterIsFavourite) {
      state = state.where((m) => m.name != character.name).toList();
    } else {
      state = [...state, character];
    }
  }
}

final favouritesProvider =
    StateNotifierProvider<FavouritesNotifier, List<Character>>((ref) {
  return FavouritesNotifier();
});
